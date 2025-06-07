import axios, { AxiosRequestConfig, AxiosResponse } from "@ohos/axios";
import { logger } from ".";


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
},(err:string)=>{
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

