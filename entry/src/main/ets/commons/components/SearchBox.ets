@Component
export struct SearchBox {
  @Prop boxHeight: number = 32
  @Prop ph: ResourceStr = '搜索题目'
  @Prop phColor: ResourceColor = $r('app.color.common_gray_02')
  @Prop bgColor: ResourceColor = $r('app.color.common_gray_border')

  build() {
    Row({ space: 4 }){
      Image($r('app.media.ic_common_search'))
        .width(14)
        .aspectRatio(1)
        .fillColor(this.phColor)
      Text(this.ph)
        .fontSize(14)
        .fontColor(this.phColor)
    }
    .width('100%')
    .height(this.boxHeight)
    .backgroundColor(this.bgColor)
    .borderRadius(this.boxHeight / 2)
    .justifyContent(FlexAlign.Center)
  }
}