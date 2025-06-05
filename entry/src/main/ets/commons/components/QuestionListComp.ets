import { QuestionItem } from "../../models/QuestionItem"
import { QuestionItemComp } from "./QuestionItemComp"

@Component
export struct QuestionListComp {
  @State list: QuestionItem[] = []
  @State isRefreshing: boolean = false

  @State
  isLoading :boolean=false
  @State
  isFinished :boolean=false
  build() {
    Refresh({ refreshing: $$this.isRefreshing }) {
      List() {
        ForEach(this.list, (item:QuestionItem) => {
          ListItem() {
            QuestionItemComp({data:item})
          }
        })

        ListItem() {
          // 加载完成
          if (this.isFinished) {
            Row() {
              Text('没有更多了~')
                .fontSize(14)
                .fontColor($r('app.color.common_gray_03'))
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
          }
          // 没有加载完成且正在加载中
          else if (this.isLoading) {
            Row({ space: 4 }) {
              LoadingProgress()
                .width(20)
              Text('正在加载...')
                .fontSize(14)
                .fontColor($r('app.color.common_gray_03'))
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
          }
        }
        .height(80)

      }
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.common_gray_border'),
        startMargin: 16,
        endMargin: 16
      })
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
      .onReachEnd(()=>{
        if (this.isLoading||this.isRefreshing||this.isFinished) {
          return
        }
        this.isLoading=true
        this.onLoading()
      })
    }.onRefreshing(() => {
      this.onRefresh()
    })

  }
  onLoading(){
    if (this.list.length<40) {
      setTimeout(() => {
        this.isLoading=false
        for (let i = 0; i < 10; i++) {
          this.list.push({
            id: '100',
            stem: '请说下ArkUI的容器组件有哪些？',
            difficulty: 3,
            likeCount: i,
            views: 423,
            readFlag: 1
          })
        }
      }, 1000)
    }else {
      this.isFinished=true
    }
  }

  onRefresh() {
    setTimeout(() => {
      this.isRefreshing = false
      this.isFinished = false
    }, 1000)
  }
}