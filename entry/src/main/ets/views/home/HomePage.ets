import { ClockInIcon } from "../../commons/components/ClockInIcon"
import { HomeCategory } from "./HomeCategory"
import { SearchBox } from "../../commons/components/SearchBox"

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
      Swiper() {
        ForEach([$r('app.media.banner_ai'), $r('app.media.banner_pj'), $r('app.media.banner_qa')],
          (item: ResourceStr) => {
            Row() {
              Image(item)
                .width('100%')
                .aspectRatio(2.65)
                .objectFit(ImageFit.Fill)
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
          })
      }
      .margin({ bottom: 16 })
      .autoPlay(true)
      .indicator(DotIndicator.dot()
      .bottom(4)
      .itemHeight(4)
      .selectedItemHeight(4)
      .selectedColor($r('app.color.white')))
      Column(){
        HomeCategory()
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor($r('app.color.white'))
    }
    .padding({ top: this.statusBarHeight })
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.common_gray_bg'))
  }


}