import { permission } from '../commons/utils/Permission';
import { Permissions } from '@kit.AbilityKit';
import { promptAction, router } from '@kit.ArkUI';

@Entry
@Component
struct RecordPage {
  @State message: string = 'Hello World';
  permissionList:Permissions[]=["ohos.permission.MICROPHONE"]

  comfirmDialog: promptAction.ShowDialogOptions={title:'提示',message:'请授权录音权限',
    buttons: [
      { text: '离开', color: $r('app.color.common_gray_01') },
      { text: '去授权', color: $r('app.color.black') }
    ]}
  aboutToAppear(): void {
    this.handlePermission()

  }

  async handlePermission() {
    const res=await permission.requestPermissions(this.permissionList)
    if (res) {
      return
    }
    const dialogResult=await promptAction.showDialog(this.comfirmDialog)
    if (dialogResult.index==1) {
      const result=await permission.openPermissionSetting(this.permissionList)
      if (result) {
        return
      }
    }
    router.back()
  }


  build() {
    RelativeContainer() {
      Text(this.message)
        .id('RecordPageHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
    }
    .height('100%')
    .width('100%')
  }
}