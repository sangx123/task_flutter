
class HttpApi {
  static const String users = 'users/sangx123';
  static const String search = 'search/repositories';
  static const String upload = 'uuc/upload-inco';

  //登陆注册
  static const String login = 'api/index/login';

  //用户注册
  static const String register = "api/index/register";

  //获取用户信息
  static const String getUserInfo= "api/user/getUserInfo";

  //创建任务
  static const String createTask = "api/task/createTask";

  //获取首页--任务列表
  static const String getHomeBusinessTaskList = "api/task/getHomeBusinessTaskList";

  //获取我的界面---我发布的任务列表
  static const String getMyPublishTaskList = "api/task/getMyPublishTaskList";


  //获取我的界面---我发布的任务人员列表
  static const String getMyPublishUserTask = "api/task/getMyPublishUserTask";

  //获取任务分类
  static const String getTaskMainType = "api/task/getTaskMainType";

  //获取任务详情
  static const String getTaskById = "api/task/getTaskById";

  //申请任务
  static const String applyTask = "api/task/applyTask";


  //获取根据usertaskId获取用户任务详情
  static const String getUserTaskById = "api/task/getUserTaskById";

  //商家是否同意申请
  static const String isBusinessAllowUserTask = "api/task/isBusinessAllowUserTask";


  //获取我接收的任务列表
  static const String getMyJieShouTaskQuanBuList = "api/task/getMyJieShouTaskQuanBuList";

  //用户提交任务

  static const String userTaskFirstSubmit="api/task/userTaskFirstSubmit";

  //商户审核用户提交的任务
  static const String businessAuditFirstSubmit="api/task/businessAuditFirstSubmit";

}