import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';
import { HcNavBar } from '../commons/components/HcNavBar';


@Entry
@Component
struct WebPage {
  @State url: string = '';
  @State title: string = '';
  @StorageProp('navigationHeight')
  navigationHeight:number=0
  webController=new webview.WebviewController()

  aboutToAppear(): void {
    const params=router.getParams() as Record<string,string>
    this.url=params.url ?? ''
    this.title=params.title ?? ''
  }
  build() {
    Column() {
      HcNavBar({ title: this.title, showRightIcon: false })
      Web({src:this.url,controller:this.webController})
    }
    .height('100%')
    .width('100%')
    .padding({bottom:this.navigationHeight})
  }
}