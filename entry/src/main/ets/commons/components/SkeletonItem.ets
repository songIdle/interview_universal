@Component
export struct SkeletonItem{
  @State op:number=1
  @Prop skeletonWidth:number=0
  build(){
    Column()
      .width(this.skeletonWidth)
      .height(30)
      .backgroundColor('#ccc')
      .onAppear(()=>{
        animateTo({duration:1000,iterations:-1,playMode:PlayMode.Alternate},()=>{
          this.op=0.5
        })
      })
      .opacity(this.op)
  }
}