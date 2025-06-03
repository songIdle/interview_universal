import { HcTag } from "../../commons/components/HcTag"
import { QuestionItemComp } from "../../commons/components/QuestionItemComp"
import { QuestionType } from "../../models/QuestionType"

@Component
export struct HomeCategory {
  @State questionTypeList: QuestionType[] = mockData
  @State activeIndex: number = 0


  build() {
    Tabs({ index: this.activeIndex }) {
      ForEach(this.questionTypeList, (item: QuestionType, i) => {
        TabContent() {
          QuestionItemComp({data:{
            id: '100',
            stem: '请说下ArkUI的容器组件有哪些？',
            difficulty: 3,
            likeCount: 23,
            views: 423,
            readFlag: 1
          }})
        }
        .tabBar(this.TabBarBuilder(item,i))
      })
    }
    .onTabBarClick((i) => {
      this.activeIndex = i
    })
    .barMode(BarMode.Scrollable)
    .barHeight(44)
    .scrollable(false)
    .divider({ strokeWidth: 0.5, color: $r('app.color.common_gray_border') })
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
    .padding({ left: 16, right: this.questionTypeList.length === i + 1 ? 16 : 0 })
  }
}


const mockData: QuestionType[] = [
  { id: 1, name: 'ArkTS', displayNewestFlag: 0 },
  { id: 2, name: 'ArkUI', displayNewestFlag: 1 },
  { id: 3, name: 'Hap', displayNewestFlag: 1 },
  { id: 4, name: 'Hsp', displayNewestFlag: 0 },
  { id: 5, name: 'Har', displayNewestFlag: 0 },
  { id: 6, name: 'Ability', displayNewestFlag: 0 },
  { id: 7, name: 'Stage', displayNewestFlag: 0 },
  { id: 8, name: 'Kit', displayNewestFlag: 0 }
]