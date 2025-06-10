import { HcNavBar } from '../commons/components/HcNavBar'
import { HcTag } from '../commons/components/HcTag'
import { promptAction, router } from '@kit.ArkUI'
import { QuestionItem, QuestionItemParams } from '../models/QuestionItem'
import { http, logger } from '../commons/utils'
import { QuestionDetailModel } from '../models/QuestionDetailModel'
import { webview } from '@kit.ArkWeb'
import { HcLoadingDialog } from '../commons/components/HcLoadingDialog'
import { QuestionShareDialog } from '../views/question/QuestionShareDialog'


@Entry
@Component
struct QuestionPage {
  @StorageProp('bottomHeight') bottomHeight: number = 0

  @State
  item: Partial<QuestionDetailModel>={}

  @State
  questionList:QuestionItem[]=[]
  currentIndex:number=0

  controller=new webview.WebviewController()

  //通过new来创建一个加载弹窗
  dialog = new CustomDialogController({
    builder: HcLoadingDialog(),
    customStyle: true,
    alignment: DialogAlignment.Center,
  });

  shareDialog = new CustomDialogController({
    builder: QuestionShareDialog({ item: this.item as QuestionDetailModel}),
    customStyle: true,
    alignment: DialogAlignment.Center,
  });

  aboutToAppear() :void{
    const data=router.getParams() as QuestionItemParams
    this.questionList=data.list
    this.currentIndex=data.currentIndex
    logger.debug('',JSON.stringify(this.questionList))
    this.getDataDetail(data.item.id)
  }

  async getDataDetail(id:string){
    this.dialog.open()
    const res=await http.request<QuestionDetailModel>({url:`question/${id}`})
    this.item=res
    //通过close和open操作dialog
    this.dialog.close()

    this.controller.runJavaScript(`writeHtml(\`${this.item.answer}\`)`)
  }


  onPageHide(): void {
    this.dialog.close()
  }

  @Builder
  TitleBuilder(text: string) {
    Row() {
      Text()
        .width(2)
        .height(12)
        .backgroundColor($r('app.color.black'))
        .margin({ right: 13 })
      Text(text)
        .fontWeight(700)
    }
    .width('100%')
    .padding({ top: 10 })
    .height(32)
  }

  @Builder
  MenuBuilder() {
    Menu() {
      MenuItem({ content: '点赞' })
      MenuItem({ content: '收藏' })
      MenuItem({ content: '点我反馈' })
      MenuItem({ content: '试题分享' })
        .onClick(() => {
          this.shareDialog.open()
        })
    }
    .width(108)
  }

  build() {
    Column() {
      HcNavBar({ title: '试题详情', showRightIcon: false })
      // 题目
      this.TitleBuilder('题目：')
      Text(''+this.item.stem)
        .width('100%')
        .padding(16)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      Row({ space: 12 }) {
        HcTag({ text: 'HarmonyOS' })
        HcTag({ text: 'ArkTS', color: '#ff6600' })
        Blank()
        Image($r("app.media.ic_home_more"))
          .width(20)
          .aspectRatio(1)
          .bindMenu(this.MenuBuilder())
      }
      .width('100%')
      .padding({ bottom: 16, left: 16, right: 16 })

      Divider()
        .strokeWidth(8)
        .color($r('app.color.common_gray_bg'))
      // 内容
      this.TitleBuilder('答案：')
      if (this.item.answer) {
        Web({src:$rawfile('question.html'),controller:this.controller})
          .layoutWeight(1)
          .padding(16)
          .onPageEnd(()=>{
            this.controller.runJavaScript(`writeHtml(\`${this.item.answer}\`)`)
          })
      }


      Row({ space: 80 }) {
        Row() {
          Image($r('sys.media.ohos_ic_public_arrow_left'))
            .width(20)
            .aspectRatio(1)
            .fillColor($r('app.color.common_gray_01'))
          Text(' 上一题')
            .fontColor($r('app.color.common_gray_01'))
            .onClick(() => {
              if (this.currentIndex==0){
                promptAction.showToast({message:'已经是第一个啦'})
                return
              }
              this.currentIndex--
              this.getDataDetail(this.questionList[this.currentIndex].id)
            })
        }

        Row() {
          Text('下一题 ')
            .fontColor($r('app.color.common_gray_03'))
          Image($r('sys.media.ohos_ic_public_arrow_right'))
            .width(20)
            .aspectRatio(1)
            .fillColor($r('app.color.common_gray_03'))
            .onClick(()=>{
              if (this.currentIndex+1==this.questionList.length){
                promptAction.showToast({message:'已经是最后一个啦'})
                return
              }
              this.currentIndex++
              this.getDataDetail(this.questionList[this.currentIndex].id)
            })
        }
      }
      .height(44)
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding({ bottom: this.bottomHeight })
  }
}