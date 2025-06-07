export interface User {
  id: string
  username: string
  avatar: string
  token: string
  nickName?: string
  // 学习时长
  totalTime?: number
  // 打卡次数
  clockinNumbers?: number
}

export interface LoginParams {
  /**
   * 密码
   */
  password: string;
  /**
   * 用户名
   */
  username: string;
}