import { FilterButton } from "../../commons/components/FilterButton"
import { HcTag } from "../../commons/components/HcTag"
import { QuestionItemComp } from "../../commons/components/QuestionItemComp"
import { QuestionListComp } from "../../commons/components/QuestionListComp"
import { http } from "../../commons/utils/Http"
import { SortType } from "../../models/QuestionItem"
import { QuestionType } from "../../models/QuestionType"

@Component
export struct HomeCategory {
  @State questionTypeList: QuestionType[] = []
  @State activeIndex: number = 0
  @State isShow: boolean = false
  @State filterDataIndex: number = 0
  @State filterDataSort:SortType=SortType.Default
  @State sort:SortType=SortType.Default

  async aboutToAppear() {
    const res=await http.request<QuestionType[]>({
      url:'question/type'
    })
    this.questionTypeList=res
  }

  build() {
    Stack({alignContent:Alignment.TopEnd}){
      Tabs({ index: this.activeIndex }) {
        ForEach(this.questionTypeList, (item: QuestionType, i) => {
          TabContent() {
            QuestionListComp({typeId:item.id,sortType:this.sort})
          }
          .tabBar(this.TabBarBuilder(item,i))
        })
      }
      .onTabBarClick((i) => {
        this.activeIndex = i
        this.filterDataIndex=i
      })
      .barMode(BarMode.Scrollable)
      .barHeight(44)
      .scrollable(false)
      .divider({ strokeWidth: 0.5, color: $r('app.color.common_gray_border') })

      Row() {
        Image($r('app.media.ic_home_filter'))
          .width(24)
          .aspectRatio(1)
      }
      .width(56)
      .height(44)
      .justifyContent(FlexAlign.Center)
      .linearGradient({ angle: 90, colors: [['#00FFFFFF', 0], ['#FFFFFF', 0.285]] })
      .bindSheet($$this.isShow, this.FilterSheetBuilder(), {
        showClose: false,
        height: 400
      })
      .onClick(() => {
        this.isShow = true
      })
    }
  }

  @Builder
  TabBarBuilder(item: QuestionType, i: number) {
    Row() {
      Stack({ alignContent: Alignment.Bottom }){
        Text(item.name)
          .fontSize(15)
          .fontColor(this.activeIndex === i ? $r('app.color.black') : $r('app.color.common_gray_01'))
          .height(44)
        Divider()
          .width(this.activeIndex === i ? 20 : 0)
          .height(2)
          .backgroundColor($r('app.color.black'))
          .animation({ duration: this.activeIndex === i ? 300 : 0 })
      }
      if (item.displayNewestFlag === 1) {
        Image($r('app.media.ic_home_new'))
          .width(32)
          .height(14)
          .objectFit(ImageFit.Contain)
          .margin({ left: 4 })
      }
    }
    .padding({ left: 16, right: this.questionTypeList.length === i + 1 ? 72 : 0 })
  }


  @Builder
  FilterSheetBuilder() {
    Column() {
      Row() {
        Text('重置')
          .fontSize(16)
          .fontWeight(500)
          .fontColor($r('app.color.common_gray_03'))
          .onClick(() => {
            this.filterDataIndex=0
            this.filterDataSort=SortType.Default
          })
        Text('筛选题目')
          .layoutWeight(1)
          .fontSize(18)
          .fontWeight(500)
          .fontColor($r('app.color.black'))
          .textAlign(TextAlign.Center)
        Text('完成')
          .fontWeight(500)
          .fontSize(16)          .fontColor($r('app.color.common_main_color'))
          .onClick(() => {
            this.isShow=false
            this.activeIndex=this.filterDataIndex
            this.sort=this.filterDataSort
          })
      }
      .margin({ bottom: 4, top: 4 })

      Text('题目排序')
        .textTitle()
      // 排序方式
      Flex({ wrap: FlexWrap.Wrap }) {
        FilterButton({ text: '默认',selected: this.filterDataSort==SortType.Default})
          .onClick(() => {
            this.filterDataSort=SortType.Default
          })
        FilterButton({ text: '浏览量', isSort: true,
          selected: this.filterDataSort==SortType.ViewHigh||this.filterDataSort==SortType.ViewLow,
          isHigh:this.filterDataSort == SortType.ViewHigh})
          .onClick(() => {
            if (this.filterDataSort==SortType.ViewHigh) {
              this.filterDataSort=SortType.ViewLow
            }else {
              this.filterDataSort=SortType.ViewHigh
            }
          })
        FilterButton({ text: '难度', isSort: true,
          selected: this.filterDataSort==SortType.DifficultyLow||this.filterDataSort==SortType.DifficultyHigh,
          isHigh:this.filterDataSort == SortType.DifficultyHigh})
          .onClick(() => {
            if (this.filterDataSort==SortType.DifficultyHigh) {
              this.filterDataSort=SortType.DifficultyLow
            }else {
              this.filterDataSort=SortType.DifficultyHigh
            }

          })
        FilterButton({ text: '推荐',selected: this.filterDataSort==SortType.Commend})
          .onClick(() => {
            this.filterDataSort=SortType.Commend
          })
      }

      Text('选择分类')
        .textTitle()
      // 选择分类
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.questionTypeList, (item: QuestionType,index:number) => {
          FilterButton({
            text: item.name,
            isNew: item.displayNewestFlag === 1,
            selected: this.filterDataIndex === index
          })
            .onClick(() => {
              this.filterDataIndex = index
            })
        })
      }
    }
    .padding(16)
    .backgroundColor($r('app.color.white'))
    .height('100%')
  }
}

@Extend(Text)
function textTitle() {
  .fontSize(14)
  .fontWeight(500)
  .fontColor($r('app.color.black'))
  .width('100%')
  .margin({ top: 20 })
}

