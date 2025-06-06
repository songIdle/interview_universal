import { SkeletonItem } from "./SkeletonItem"

@Component
export struct Skeleton{


  build(){
    Column(){
      ForEach(new Array(6).fill(0),  () => {
        Column({ space: 10 }) {
          Row({ space: 5 }) {
            SkeletonItem({skeletonWidth:34})
            SkeletonItem({skeletonWidth:250})
          }
          .width('100%')

          Row({space:5}) {
            SkeletonItem({skeletonWidth:50})
            SkeletonItem({skeletonWidth:50})
            SkeletonItem({skeletonWidth:50})
          }
        }
        .padding({ left: 16, right: 16 })
        .width('100%')
        .height(80)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
      })
    }


  }
}