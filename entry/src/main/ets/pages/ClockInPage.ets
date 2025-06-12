import { HmCalendar, HmCalendarSelectedDay } from '@ohmos/calendar'
import { HcNavBar } from '../commons/components/HcNavBar'
import { httpUtil, logger } from '../commons/utils'
import { ClockInfo, ClockInfoParams } from '../models/ClockData'

interface DayBuilderParams {
  day: number
  text: string
}

@Entry
@Component
struct ClockInPage {
  @StorageProp('statusBarHeight')
  topHeight: number = 0
  @State clockInfo: ClockInfo = {
    flag: false,
    clockinNumbers: 0,
    totalClockinNumber: 0,
    clockins: []
  }
  @State selectedDays: HmCalendarSelectedDay[] = []
  aboutToAppear(): void {
    const current = new Date()
    this.getClockInfo({ year: current.getFullYear().toString(), month: (current.getMonth() + 1).toString() })
  }

  async getClockInfo (params: ClockInfoParams) {
    const res = await httpUtil.request<ClockInfo>({ url: 'clockinInfo', params })
    this.clockInfo = res
    this.selectedDays = res.clockins.map(item=>({ date: item.createdAt } as HmCalendarSelectedDay))
  }

  @Builder
  dayBuilder(params: DayBuilderParams) {
    Column() {
      Row() {
        Text(params.day.toString())
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
        Text('天')
          .fontSize(10)
          .fontColor($r('app.color.common_gray_01'))
          .margin({ bottom: 8, left: 10 })
      }
      .alignItems(VerticalAlign.Bottom)

      Text(params.text)
        .fontSize(10)
        .fontColor($r('app.color.common_gray_01'))
    }.margin({ right: 36 })
  }

  build() {
    Column({ space: 16 }) {
      HcNavBar({ title: '每日打卡', showRightIcon: false })
      Row() {
        this.dayBuilder({ day: this.clockInfo.totalClockinNumber, text: '累计打卡' })
        this.dayBuilder({ day: this.clockInfo.clockinNumbers, text: '连续打卡' })
      }
      .padding({ top: 10, bottom: 25, left: 16, right: 16 })
      .width('100%')
      .justifyContent(FlexAlign.Start)
      Row() {
        Row(){
          HmCalendar({
            selectedDays:this.selectedDays,
            onChangeMonth: (month:string) => {
              const selectMonth=month.split('-')[1]
              this.getClockInfo({ year: new Date().getFullYear().toString(), month: selectMonth })
            }
          })
          .borderRadius(8)
          .border({ width: 0.5, color: '#ededed' })
          .shadow({ color: '#ededed', radius: 16 })
          .backgroundColor($r('app.color.white'))
        }
        .height(350)
        .width('100%')
        .borderRadius(8)
        .border({ width: 0.5, color: '#ededed' })
        .shadow({ color: '#ededed', radius: 16 })
        .backgroundColor($r('app.color.white'))
        .clip(true)
      }
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.clocked_bg'))
    .backgroundImageSize({ width: '100%' })
    .padding({ top: this.topHeight })
  }
}