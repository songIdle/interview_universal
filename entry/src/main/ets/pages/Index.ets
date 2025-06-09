import { auth, fullScreen } from '../commons/utils/';
import { HomePage } from '../views/home/HomePage';
import { InterviewPage } from '../views/interview/InterviewPage';
import { MyPage } from '../views/my/MyPage';
import { ProjectPage } from '../views/project/ProjectPage';


interface TabItem {
  icon: Resource;
  activeIcon: Resource;
  name: string;
}

auth.initUser()


@Entry
@Component
struct Index {
  @StorageProp('navigationHeight')
  navigationHeight:number=0

  @State
  currentTabIndex:number=0
  // struct Index 数据
  tabList: TabItem[] = [
    {
      icon: $r('app.media.tabbar_home'),
      activeIcon: $r('app.media.tabbar_home_fill'),
      name: '首页'
    },
    {
      icon: $r('app.media.tabbar_project'),
      activeIcon: $r('app.media.tabbar_project_fill'),
      name: '项目'
    },
    {
      icon: $r('app.media.tabbar_interview'),
      activeIcon: $r('app.media.tabbar_interview_fill'),
      name: '面经'
    },
    {
      icon: $r('app.media.tabbar_mine'),
      activeIcon: $r('app.media.tabbar_mine_fill'),
      name: '我的'
    }
  ]

  aboutToAppear(): void {
    fullScreen.enable()
  }


  build() {
    Column() {
      Tabs({index:this.currentTabIndex}){
        ForEach(this.tabList, (item:TabItem,index) => {
          TabContent(){
            if (index==0) {
              HomePage()
            }else if (index==1) {
              ProjectPage()
            }else if (index==2) {
              InterviewPage()
            }else {
              MyPage()
            }
          }.tabBar(this.TabBarBuilder(item, index))
        })
      }
      .width('100%')
      .height('100%')
      .scrollable(false)
      .barPosition(BarPosition.End)
      .onChange((index: number) => {
        this.currentTabIndex = index
      })
      .animationDuration(0)
      .divider({ strokeWidth: 0.5, color: $r('app.color.common_gray_border') })
    }
    .height('100%')
    .width('100%')
    .padding({
      bottom: this.navigationHeight
    })
  }

  @Builder
  TabBarBuilder(item: TabItem, index: number) {
    Column({ space: 5 }) {
      Image(this.currentTabIndex === index ? item.activeIcon : item.icon)
        .width(24)
        .aspectRatio(1)
      Text(item.name)
        .fontSize(12)
        .fontColor(this.currentTabIndex === index ? $r('app.color.black') : $r('app.color.common_gray_01'))
    }
  }
}