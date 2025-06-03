import { ClockInIcon } from "./ClockInIcon"
import { SearchBox } from "./SearchBox"

@Component
export struct HomePage{
  @StorageProp('statusBarHeight')
  statusBarHeight:number=0
  build() {
    Column() {
      Row({ space: 16 }) {
        Image($r('app.media.ic_home_scan'))
          .width(24)
          .aspectRatio(1)
        Blank()
        SearchBox({layoutWeightValue:1})
        ClockInIcon({clockInCount:8})
      }
      .padding({ left: 16, right: 16 })
      .height(64)
      .width('100%')
    }
    .padding({ top: this.statusBarHeight })
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.common_gray_bg'))
  }


}