import { http, logger } from ".";
import { TimeItem } from "../../models/TimeItem";



class Tracking {
  list: TimeItem[] = [];

  record(startTime: number, endTime: number, questionId: string) {
    this.list.push({
      startTime,
      endTime,
      questionId,
    });
    logger.debug("Tracking", JSON.stringify(this.list));
  }

  async report() {
    await http.request<null>({ url: "time/tracking", method: "post", data: { timeList: this.list } });
    this.list = [];
  }
}

export const tracking = new Tracking();