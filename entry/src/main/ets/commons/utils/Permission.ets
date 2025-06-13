import { abilityAccessCtrl, Permissions } from "@kit.AbilityKit"

export class Permission {
  // 第一次申请
  async requestPermissions(list: Permissions[]) {
    // requestPermissionsFromUser
    // 权限能力控制 模块
    let ctx = AppStorage.get<Context>('context')
    let manager = abilityAccessCtrl.createAtManager() // 创建实例  权限管理实例
    if (ctx) {
      let res = await manager.requestPermissionsFromUser(ctx, list)
      // res.authResults // 用户授权的结果   [-1, 0, -1, 0]
      return res.authResults.every(item => {
        return item == abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED
      }) // true  权限都同意    false

      // abilityAccessCtrl.GrantStatus.PERMISSION_DENIED  -1  拒绝
      // abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED  0  同意
    }

    return false // 权限未获取到
  }

  // 第二次申请
  async openPermissionSetting(list: Permissions[]) {
    let manager = abilityAccessCtrl.createAtManager() // 创建权限管理实例
    let ctx = AppStorage.get<Context>('context')
    if (ctx) {
      let res = await manager.requestPermissionOnSetting(ctx, list)
      return res.every(item => item == abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED)
    }

    return false
  }
}

export const permission = new Permission()