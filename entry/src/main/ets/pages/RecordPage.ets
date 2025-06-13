import { permission } from '../commons/utils/Permission';
import { Permissions } from '@kit.AbilityKit';
import { promptAction, router } from '@kit.ArkUI';
import { media } from '@kit.MediaKit';
import { fileIo } from '@kit.CoreFileKit';

@Entry
@Component
struct RecordPage {
  @StorageProp('statusBarHeight')
  topHeight: number = 0
  @State message: string = 'Hello World';
  permissionList:Permissions[]=["ohos.permission.MICROPHONE"]

  avRecord:media.AVRecorder|null=null
  file:fileIo.File|null=null
  comfirmDialog: promptAction.ShowDialogOptions={title:'提示',message:'请授权录音权限',
    buttons: [
      { text: '离开', color: $r('app.color.common_gray_01') },
      { text: '去授权', color: $r('app.color.black') }
    ]}
  aboutToAppear(): void {
    this.handlePermission()
  }

  async handlePermission() {
    const res=await permission.requestPermissions(this.permissionList)
    if (res) {
      return
    }
    const dialogResult=await promptAction.showDialog(this.comfirmDialog)
    if (dialogResult.index==1) {
      const result=await permission.openPermissionSetting(this.permissionList)
      if (result) {
        return
      }
    }
    router.back()
  }

  async startRecord(){
    const cxt=getContext()
    const filePath=cxt.filesDir+'/'+Date.now()+'.m4a'
    this.file=fileIo.openSync(filePath,fileIo.OpenMode.CREATE|fileIo.OpenMode.READ_WRITE)
    this.avRecord=await media.createAVRecorder()
    await this.avRecord.prepare({
      audioSourceType: media.AudioSourceType.AUDIO_SOURCE_TYPE_MIC, // 录制的音频源类型  表示MIC的音频输入源
      // 音频
      profile: {
        audioBitrate: 100000, // 音频编码比特率
        audioChannels: 2, // 采集声道数
        audioCodec: media.CodecMimeType.AUDIO_AAC, // 音频编码格式
        audioSampleRate: 48000, // 音频采样率
        fileFormat: media.ContainerFormatType.CFT_MPEG_4A // 文件的容器格式
      }, // 配置文件
      url: `fd://${this.file.fd}` // 录制的音频存在哪个文件中  文件.fd
    })
    this.avRecord.start()
  }


  async stopRecord(){
    await this.avRecord?.stop()
    this.avRecord?.release()
  }

  async playRecord(){
    const avplayer=await media.createAVPlayer()
    avplayer.on('stateChange', state => {
      if (state=='initialized') {
        avplayer.prepare()
      }
      if (state== 'prepared') {
        avplayer.play()
      }
    })
    avplayer.url=`fd://${this.file?.fd}`
  }

  build() {
    Column() {
      Button('点击录音')
        .onClick(() => {
          this.startRecord()
        })
      Button('点击停止')
        .onClick(() => {
          this.stopRecord()
        })
      Button('点击播放')
        .onClick(() => {
          this.playRecord()
        })
    }
    .height('100%')
    .width('100%')
    .padding({top:this.topHeight})
  }
}