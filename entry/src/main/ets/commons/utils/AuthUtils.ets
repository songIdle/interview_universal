import { User } from "../../models/User";
import { router } from "@kit.ArkUI";


export const USER_INFO = 'user'
export class Auth{
  initUser(){
    PersistentStorage.persistProp<User>(USER_INFO,{} as User)
  }
  setUser(user:User){
    AppStorage.set(USER_INFO,user)
  }
  getUser(){
    return AppStorage.get<User>(USER_INFO) || {} as User
  }

  checkAuth(options:router.RouterOptions){
    if (this.getUser().token) {
      router.pushUrl(options)
    }else {
      router.pushUrl({url:'pages/LoginPage',params:options})
    }
  }
  checkLogin(event:()=>void){
    if(this.getUser().token) {
      event()
    }else {
      router.pushUrl({url:'pages/LoginPage'})
    }
  }
}

export const auth=new Auth()