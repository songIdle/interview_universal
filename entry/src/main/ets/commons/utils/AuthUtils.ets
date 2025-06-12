import { User } from "../../models/User";
import { promptAction, router } from "@kit.ArkUI";
import { httpUtil } from ".";
import { ClockData } from "../../models/ClockData";


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

export function requestClock(){
  let user=auth.getUser()
  auth.checkLogin(async ()=>{
    if (!user.clockinNumbers) {
      const res=await httpUtil.request<ClockData>({ url:'clockin' })
      user.clockinNumbers=res.clockinNumbers
      auth.setUser(user)
      promptAction.showToast({message:'打卡成功'})
    }
    router.pushUrl({url:'pages/ClockInPage'})
  })
}