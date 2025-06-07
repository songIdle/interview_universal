import { User } from "../../models/User";


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
}

export const auth=new Auth()