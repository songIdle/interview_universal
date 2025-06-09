import { QuestionItem, QuestionListType, SortType } from "../../models/QuestionItem"
import { auth } from "../utils"
import { http } from "../utils/Http"
import { QuestionItemComp } from "./QuestionItemComp"
import { Skeleton } from "./Skeleton"
import { SkeletonItem } from "./SkeletonItem"

@Component
export struct QuestionListComp {

  typeId:number=0
  @State list: QuestionItem[] = []
  @State isRefreshing: boolean = false
  @Prop
  @Watch('fn')
  sortType:SortType=SortType.Default
  @State
  isLoading :boolean=false
  @State
  isFinished :boolean=false

  pageNum:number=1

  fn(){
    this.isRefreshing=true
  }

  build() {
    if (this.isLoading &&  this.list.length==0){
      Skeleton()
    }else {
      Refresh({ refreshing: $$this.isRefreshing }) {
        List() {
          ForEach(this.list, (item:QuestionItem) => {
            ListItem() {
              QuestionItemComp({data:item})
                .onClick(()=>{
                  auth.checkAuth({url:'pages/QuestionDetailPage',params:{
                    data:item
                  }})
                })
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


  }
  async onLoading(){
    const res=await this.getListData()
    this.list.push(...res.rows!!)
    this.isLoading=false
    if (res.pageTotal==this.pageNum) {
      this.isFinished=true
    }else {
      this.pageNum++
    }
  }

  async getListData(){
    return await http.request<QuestionListType>({
      url:'question/list',
      params:{
        questionBankType:10,
        type:this.typeId,
        pageSize:10,
        page:this.pageNum,
        sort:this.sortType
      }
    })
  }

  async onRefresh() {
    this.isFinished = false
    this.pageNum=1
    const res=await this.getListData()
    this.list=res.rows!!
    this.isRefreshing=false
    if (res.pageTotal==this.pageNum) {
      this.isFinished=true
    }else {
      this.pageNum++
    }
  }
}