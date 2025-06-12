import { logger, USER_INFO } from "../../commons/utils"
import { User } from "../../models/User"
import { componentSnapshot, promptAction } from "@kit.ArkUI"
import image from "@ohos.multimedia.image"
import { fileIo, fileUri } from "@kit.CoreFileKit"
import { photoAccessHelper } from "@kit.MediaLibraryKit"
import { QuestionItem } from "../../models/QuestionItem"


@CustomDialog
export struct QuestionShareDialog {
  @Prop item: QuestionItem
  @StorageProp(USER_INFO) user: User = {} as User

  controller: CustomDialogController
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: 20 }) {
        Image($r('app.media.ic_interview_logo'))
          .width(40)
          .height(40)
        Text('面试通，搞定企业面试题')
        Divider()
          .strokeWidth(0.5)
          .color($r('app.color.common_gray_border'))
        Text('大厂面试题：' + this.item.stem)
          .fontSize(12)
          .maxLines(2)
          .fontWeight(600)
          .width('100%')
          .lineHeight(24)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        QRCode(this.item.id)
          .width(160)
          .height(160)
          .alignSelf(ItemAlign.Center)
        Text('扫码查看答案')
          .fontSize(12)
          .alignSelf(ItemAlign.Center)
        Blank()
        Text('分享来自：' + this.user.nickName || this.user.username)
          .fontSize(12)
      }
      .id('share')
      .padding(20)
      .alignItems(HorizontalAlign.Start)
      .width(300)
      .height(500)
      .backgroundColor($r('app.color.white'))


      Row() {
        SaveButton({text:SaveDescription.SAVE_IMAGE,buttonType:ButtonType.Normal,icon:SaveIconStyle.LINES})
          .onClick((event,result) => {
            if (result==SaveButtonOnClickResult.SUCCESS) {
              this.saveImageTo()
            }
          })
      }
      .borderRadius({ topLeft: 8 })
      .clip(true)
    }
    .borderRadius(8)
    .clip(true)
  }

  async saveImageTo(){
    //componentSnapshot用来给组件截图  share 是组件的id
    //res 的类型是 image.PixelMap
    const res=await componentSnapshot.get('share')

    // const imageBuffer=await packer.packing(res,{format:'image/jpeg',quality:70})
    // const filePath=getContext().cacheDir+'/'+Date.now()+'.jpeg'
    // const file=fileIo.openSync(filePath,fileIo.OpenMode.CREATE|fileIo.OpenMode.READ_WRITE)
    // fileIo.writeSync(file.fd,imageBuffer)
    // fileIo.closeSync(file.fd)
    // promptAction.showToast({message:'缓存成功'})

    //new ImagePacker()
    const packer=image.createImagePacker()
    const filePath=getContext().cacheDir+'/'+Date.now()+'.jpeg'
    const file=fileIo.openSync(filePath,fileIo.OpenMode.CREATE|fileIo.OpenMode.READ_WRITE)
    await packer.packToFile(res,file.fd,{format:'image/jpeg',quality:70})

    //创建相册图片的请求（uri：代号）
    const uri=fileUri.getUriFromPath(filePath)
    const request=photoAccessHelper.MediaAssetChangeRequest.createImageAssetRequest(getContext(),uri)
    //new photoAccessHelper()
    const helper=photoAccessHelper.getPhotoAccessHelper(getContext())
    //request必须用在applyChanges里面
    await helper.applyChanges(request)
    promptAction.showToast({message:'保存进相册成功'})
    this.controller.close()
  }
}