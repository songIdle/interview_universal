

export interface QuestionListType {
  /**
   * 总页数
   */
  pageTotal?: number;
  /**
   * 数据集合
   */
  rows?: QuestionItem[];
  /**
   * 总数
   */
  total?: number
}

export interface QuestionItem {
  /**
   * 内容描述-面经有,试题列表没有
   */
  content: string;
  /**
   * 新增时间
   */
  createdAt?: string;
  /**
   * 面经创建者头像
   */
  creatorAvatar: string;
  /**
   * 创建者名称
   */
  creatorName: string;
  /**
   * 难度，难度-面试题需要显示此字段，注：1-2星是简单，3-4星是一般，5星是困难
   */
  difficulty?: number;
  /**
   * 题目id
   */
  id: string;
  /**
   * 点赞数量
   */
  likeCount: number;
  /**
   * 已点赞1 未点赞0
   */
  likeFlag: number;
  /**
   * 场景教案场景，双元教案1、核心提炼2、随堂测试3、随堂练习4、每日作业
   */
  planSceneName?: PlanSceneName;
  /**
   * 题号/面经的标题
   */
  questionNo?: string;
  /**
   * 题型：1单选，2多选，3判断，5简答，6代码，7实操
   */
  questionType?: number;
  /**
   * 是否已读标志，0未读1已读
   */
  readFlag: number;
  /**
   * 题干
   */
  stem: string;
  /**
   * 题干附件-面经列表的图片
   */
  stemAttachmentId?: string;
  /**
   * 学科
   */
  subjectName?: string;
  /**
   * 浏览量
   */
  views: number;
  /**
   * 题目答案
   */
  answer: string;
  /**
   * 0未收藏1收藏
   */
  collectFlag: number;
  /**
   * 关联问题：面经才有关联问题
   */
  relatedQuestions?: RelatedQuestion[];
  /**
   * 阶段待定-知识点
   */
  stage?: string[];
}



export interface RelatedQuestion {
  /**
   * 入库时间
   */
  createdAt?: string;
  /**
   * 题目id
   */
  id: string;
  /**
   * 题号/面经的标题
   */
  questionNo?: string;
  /**
   * 题干
   */
  stem: string;
}


export enum PlanSceneName {
  Empty = "",
  其他 = "其他",
  核心提炼 = "核心提炼",
  每日作业 = "每日作业",
  随堂测试 = "随堂测试",
  随堂练习 = "随堂练习",
}

export enum SortType {
  Default = 0,
  DifficultyLow = 10,
  DifficultyHigh = 11,
  ViewLow = 20,
  ViewHigh = 21,
  Commend = 30
}

export interface QuestionItemParams{
  item:QuestionItem,
  list:QuestionItem[],
  currentIndex:number
}