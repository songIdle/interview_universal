
export interface InterViewResponse<T> {
  success: boolean;
  code: number;
  message: string;
  data: T;
}
