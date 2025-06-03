import { window } from "@kit.ArkUI"
import { logger } from "./LoggerUtil"


export class FullScreen{
  async enable(){
    try {
      const  cxt=AppStorage.get<Context>('context')
      if (cxt!=null){
        const win=await window.getLastWindow(cxt)
        //设置全屏
        win.setWindowLayoutFullScreen(true)
        // 获取状态栏高度并保存
        const statusBar=win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
        const statusBarHeight=px2vp(statusBar.topRect.height)
        AppStorage.setOrCreate('statusBarHeight',statusBarHeight)

        // 获取导航栏高度并保存
        const bottomBar=win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
        const navigationHeight=px2vp(bottomBar.bottomRect.height)
        AppStorage.setOrCreate('navigationHeight',navigationHeight)
      }
    }catch (err){
      logger.error('开启全屏错误',JSON.stringify(err))
    }
  }

  async disEnable(){
    try {
      const  cxt=AppStorage.get<Context>('context')
      if (cxt!=null){
        const win=await window.getLastWindow(cxt)
        //设置全屏
        win.setWindowLayoutFullScreen(false)

        AppStorage.setOrCreate('statusBarHeight',0)

        AppStorage.setOrCreate('navigationHeight',0)
      }
    }catch (err){
      logger.error('退出全屏错误',JSON.stringify(err))
    }
  }

}

export const fullScreen=new FullScreen()