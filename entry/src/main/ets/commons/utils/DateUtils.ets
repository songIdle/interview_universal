
export class DateUtils{
  day:number = 60 * 60 * 24
  hour:number = 60 * 60
  min:number = 60

  formatTime = (second: number|undefined) => {
    if (second==undefined){
      return '暂无数据'
    }
    if (second >this.day) {
      return (second / this.day).toFixed(1) + '天'
    } else if (second > this.hour) {
      return (second / this.hour).toFixed(1) + '小时'
    } else {
      return (second / this.min).toFixed(0) + '分钟'
    }
  }
}

export const dateUtils=new DateUtils()