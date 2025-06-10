import { http, logger } from ".";
import { TimeItem } from "../../models/TimeItem";
import { preferences } from "@kit.ArkData";


export class Tracking {
  store: preferences.Preferences|null=null
  dataKey: string = "time-list";
  getPre(){
    if (!this.store) {
      const cxt=AppStorage.get<Context>('context')
      this.store=preferences.getPreferencesSync(cxt,{name:'traking_store'})
    }
    return this.store
  }

  record(startTime:number,endTime:number,questionId:string){
    const data=this.getPre().getSync(this.dataKey,"[]")
    const list=JSON.parse(data as string) as TimeItem[]
    list.push({startTime:startTime,endTime:endTime,questionId:questionId})

    this.getPre().putSync(this.dataKey,JSON.stringify(list))
    this.getPre().flushSync()
  }

  async report(force:boolean=false){
    const json = this.getPre().getSync(this.dataKey, "[]");
    const list = JSON.parse(json as string) as TimeItem[];
    if (list.length >= 5||(force && list.length)) {
      await http.request<null>({ url: "time/tracking", method: "post", data: { timeList: list } });
      this.getPre().deleteSync(this.dataKey);
      await this.getPre().flush();
    }
  }
}

export const tracking = new Tracking();