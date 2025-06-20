import { HcNavBar } from '../commons/components/HcNavBar'
import { promptAction, router } from '@kit.ArkUI'
import { LoginParams, User } from '../models/User'
import { httpUtil } from '../commons/utils/Http'
import { auth } from '../commons/utils/AuthUtils'
import { emitter } from '@kit.BasicServicesKit'
import { LOGIN_EVENT } from '../commons/constants'
import { tracking } from '../commons/utils'


@Entry
@Component
struct LoginPage {
  @StorageProp('statusBarHeight')
  topHeight: number = 0
  @State
  username: string = 'hmheima'
  @State
  password: string = 'Hmheima%123'
  @State
  isAgree: boolean = false
  @State
  loading: boolean = false

  async login() {
    if (this.loading) {
      return
    }
    if (!this.username) {
      return promptAction.showToast({ message: '请输入用户名' })
    }
    if (!this.password) {
      return promptAction.showToast({ message: '请输入密码' })
    }
    if (!this.isAgree) {
      return promptAction.showToast({ message: '请勾选已阅读并同意' })
    }

    try {
      this.loading = true
      const user = await httpUtil.requestWithData<User, LoginParams>({
        url: 'login',
        method: 'post',
        data: {
          username: this.username,
          password: this.password
        }
      })
      this.loading = false
      //保存用户信息
      auth.setUser(user)
      //通过广播事件同步登录状态
      emitter.emit(LOGIN_EVENT)
      //上报数据
      tracking.report(true)
      const params=router.getParams() as router.RouterOptions
      if ( params) {
        router.replaceUrl(params)
      }else {
        router.back()
      }
    } catch (err) {
      this.loading = false
      promptAction.showToast({ message: err as string })
    }
  }


  build() {
    Column() {
      HcNavBar({ showRightIcon: false })
      Column() {
        Image($r('app.media.icon'))
          .width(120)
          .aspectRatio(1)
        Text('面试通')
          .fontSize(28)
          .margin({ bottom: 15 })
        Text('搞定企业面试真题，就用面试通')
          .fontSize(14)
          .fontColor($r('app.color.common_gray_01'))
      }
      .padding(16)

      Column({ space: 15 }) {
        TextInput({ placeholder: '请输入用户名', text: $$this.username })
          .customStyle()
        TextInput({ placeholder: '请输入密码', text: $$this.password })
          .type(InputType.Password)
          .showPasswordIcon(false)
          .customStyle()
        Row() {
          Checkbox()
            .shape(CheckBoxShape.ROUNDED_SQUARE)
            .selectedColor('#fa711d')
            .size({ width: 14, height: 14 })
            .select(this.isAgree)
            .onChange((val) => {
              this.isAgree = val
            })
          Text('已阅读并同意')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_01'))
            .padding({ right: 4 })
          Text('用户协议')
            .fontSize(14)
            .padding({ right: 4 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/WebPage',params:{
                url:'http://110.41.143.89/user',
                title:'用户协议'
              }})
            })
          Text('和')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_01'))
            .padding({ right: 4 })
          Text('隐私政策')
            .fontSize(14)
            .onClick(() => {
              router.pushUrl({ url: 'pages/WebPage',params:{
                url:'http://110.41.143.89/privacy',
                title:'隐私政策'
              }})
            })
        }
        .width('100%')

        Button({ type: ButtonType.Normal }) {
          Row() {
            if (this.loading) {
              LoadingProgress()
                .color($r('app.color.white'))
                .width(24)
                .height(24)
                .margin({ right: 10 })
            }
            Text('立即登录')
              .fontColor($r('app.color.white'))
          }
        }
        .width('100%')
        .backgroundColor('none')
        .borderRadius(4)
        .height(44)
        .linearGradient({
          direction: GradientDirection.Right,
          colors: [['#fc9c1c', 0], ['#fa711d', 1]]
        })
        .stateEffect(false)
        .onClick(() => {
          this.login()
        })
      }
      .padding({ left: 36, right: 36, top: 30 })


      Column() {
        Text('其他登录方式')
          .fontSize(14)
          .fontColor($r('app.color.common_gray_01'))
      }
      .padding({ top: 70, bottom: 100 })

    }
    .width('100%')
    .height('100%')
  }

}

@Extend(TextInput)
function customStyle() {
  .placeholderColor('#C3C3C5')
  .caretColor('#fa711d')
  .height(44)
  .borderRadius(0)
  .backgroundColor($r('app.color.white'))
  .border({ width: { bottom: 0.5 }, color: $r('app.color.common_gray_border') })
}