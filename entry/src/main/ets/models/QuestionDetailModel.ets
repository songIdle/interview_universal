export interface QuestionDetailModel {
  /**
   * 题目答案
   */
  answer: string;
  /**
   * 0未收藏1收藏
   */
  collectFlag: number;
  /**
   * 面经的内容，为面经时才有自豪
   */
  content: null | string;
  /**
   * 创建时间
   */
  createdAt: string;
  /**
   * 创建者头像-面经
   */
  creatorAvatar: string;
  /**
   * 创建者名称-面经
   */
  creatorName: string;
  /**
   * 题目难度，难度-面试题需要显示此字段，注：1-2星是简单，3-4星是一般，5星是困难
   */
  difficulty: number;
  /**
   * 主键id-试题id
   */
  id: string;
  /**
   * 点赞数-面经
   */
  likeCount: number;
  /**
   * 是否点赞0未点赞1已点赞
   */
  likeFlag: number;
  /**
   * 关联问题：面经才有关联问题
   */
  relatedQuestions?: RelatedQuestion[];
  /**
   * 阶段待定-知识点
   */
  stage?: string[];
  /**
   * 题目的题干/面经的标题
   */
  stem: string;
  /**
   * 浏览量
   */
  views: number;
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
