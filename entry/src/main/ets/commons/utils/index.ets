
export * from './FullScreenUtil'
export * from './LoggerUtil'
export * from './StatusBarUtil'
export * from './DateUtils'
export * from './Http'
export * from './AuthUtils'
export * from './Tracking'
export * from './History'
export * from './Permission'


export const calcPercentage = (done: number, total: number) => {
  return Math.round(done / total * 100) + '%'
}