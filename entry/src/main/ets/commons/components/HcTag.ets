@Component
export struct HcTag {
  @Prop difficulty: number = 1
  @Prop text: string = ''
  @Prop color: ResourceColor = ''

  build() {
    Text(this.text || this.getTextFromDiffculty(this.difficulty))
      .fontColor(this.color ||  this.getColorFromDiffculty(this.difficulty))
      .fontSize(10)
      .padding({ left: 6, right: 6 })
      .height(18)
      .constraintSize({ minWidth: 34 })
      .borderRadius(2)
      .backgroundColor($r('app.color.common_gray_bg'))
      .textAlign(TextAlign.Center)
  }

  getTextFromDiffculty(difficulty: number):string{
    switch (difficulty){
      case 1:
      case 2:
        return '简单'
      case 3:
      case 4:
        return '一般'
      case 5:
        return '困难'
      default:
        return '简单'
    }
  }
  getColorFromDiffculty(difficulty: number):ResourceColor{
    switch (difficulty){
      case 1:
      case 2:
        return $r("app.color.common_green")
      case 3:
      case 4:
        return $r("app.color.common_blue")
      case 5:
        return $r("app.color.common_main_color")
      default:
        return $r("app.color.common_green")
    }
  }
}