
class HttpApi {
  static const String users = 'users/sangx123';
  static const String search = 'search/repositories';
  static const String upload = 'uuc/upload-inco';

  //登陆注册
  static const String login = 'api/index/login'; //登录
  static const String register = "api/index/register"; //注册

  //创建任务
  static const String createTask = "api/task/createTask";

  //获取首页--任务列表
  static const String getHomeBusinessTaskList = "api/task/getHomeBusinessTaskList";

  //获取我的界面---我发布的任务列表
  static const String getMyPublishTaskList = "api/task/getMyPublishTaskList";

  //获取任务分类
  static const String getTaskMainType = "api/task/getTaskMainType";

  //获取任务详情
  static const String getTaskById = "api/task/getTaskById";

  //申请任务
  static const String applyTask = "api/task/applyTask";
}