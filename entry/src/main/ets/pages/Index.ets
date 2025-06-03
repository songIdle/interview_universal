import { fullScreen } from '../commons/utils/FullScreenUtil';

@Entry
@Component
struct Index {
  @State isFullScreen: boolean = false;
  @StorageProp('navigationHeight')
  navigationHeight:number=0
  @StorageProp('statusBarHeight')
  statusBarHeight:number=0
  build() {
    Column() {
      Button('开启')
        .onClick(() => {
          fullScreen.enable()
        })
      Button('关闭')
        .onClick(() => {
          fullScreen.disEnable()
        })
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Pink)
    .padding({
      top: this.statusBarHeight,bottom: this.navigationHeight
    })
  }
}