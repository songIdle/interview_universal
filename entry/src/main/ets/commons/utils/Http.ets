import axios, { AxiosError, AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from "@ohos/axios";
import { auth, logger } from ".";
import { User } from "../../models/User";
import { promptAction, router } from "@kit.ArkUI";


const instance=axios.create({
  baseURL:'https://api-harmony-teach.itheima.net/hm/',
  timeout:10000
})

instance.interceptors.response.use((response:AxiosResponse)=>{
  if (response.data.code==10000) {
    logger.debug('Req Success', JSON.stringify(response.data.data))
    return Promise.resolve(response.data.data)
  }else {
    logger.error('Req Error', JSON.stringify(response.data))
    return Promise.reject(response.data.message)
  }
},(err:AxiosError)=>{
  if (err.response?.status==401) {
    auth.setUser({} as User)
    router.pushUrl({url:'pages/LoginPage'})
    promptAction.showToast({message: '登录已过期，请重新登录'})
  }
  return Promise.reject(err)
})
instance.interceptors.request.use((config:InternalAxiosRequestConfig)=>{
  const token=auth.getUser().token
  if (token) {
    config.headers.Authorization=`Bearer ${token}`
  }
  return config
},(err:AxiosError)=>{

  return Promise.reject(err)
})


export class HttpUtils{
  request<T>(config:AxiosRequestConfig){
    return instance<null,T,null>(config)
  }
  requestWithData<T,R>(config:AxiosRequestConfig<R>){
    return instance<null,T,R>(config)
  }
}

export const http=new HttpUtils()

