import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { logger } from '../commons/utils/LoggerUtil';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    logger.info('生命周期','Ability onCreate');
    AppStorage.setOrCreate('context', this.context)
  }

  onDestroy(): void {
    logger.info('生命周期', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    logger.info( '生命周期', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        logger.error( '生命周期', 'Failed to load the content. Cause: ', JSON.stringify(err));
        return;
      }
      logger.info( '生命周期', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    logger.info( '生命周期', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    logger.info( '生命周期', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    logger.info( '生命周期', 'Ability onBackground');
  }
}