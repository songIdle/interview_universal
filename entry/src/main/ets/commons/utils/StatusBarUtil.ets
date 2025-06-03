import { window } from "@kit.ArkUI"
import { logger } from "./LoggerUtil"

export class StatusBar{
  setDarkBar() {
    this.setBar({ statusBarContentColor: '#000000' })
  }

  setLightBar() {
    this.setBar({ statusBarContentColor: '#FFFFFF' })
  }

  async setBar(config: window.SystemBarProperties) {
    try {
      const context = AppStorage.get<Context>('context')
      if (context) {
        const win = await window.getLastWindow(context)
        await win.setWindowSystemBarProperties(config)
      }
    } catch (e) {
      logger.error('StatusBar setBar', JSON.stringify(e))
    }
  }
}

export const statusBar = new StatusBar()