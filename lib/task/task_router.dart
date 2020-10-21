
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/router_init.dart';
import 'package:flutter_deer/task/page/task_type_chose_page.dart';
import 'package:flutter_deer/task/test/issuse_message_page.dart';
import 'package:flutter_deer/task/page/task_detail.dart';
import 'package:flutter_deer/task/page/task_home.dart';
import 'package:flutter_deer/task/page/task_pay.dart';
import 'package:flutter_deer/task/page/task_publish.dart';
import 'package:flutter_deer/task/page/task_publish_end.dart';

import 'test/test_forcus.dart';


class TaskRouter implements IRouterProvider{

  static String taskPublishPage = "/task/taskPublish";
  static String taskHomePage = "/task/taskHome";
  static String taskPublishEndPage = "/task/taskPublishEnd";
  static String taskDetailPage = "/task/taskDetail";
  static String myCustomForm = "/store/MyCustomForm";
  static String taskIssuesMessagePage = "/task/IssuesMessagePage";
  static String taskPayPage = "/task/taskPayPage";

  static String taskTypeChosePage = "/task/taskTypeChosePage";


  @override
  void initRouter(Router router) {
    router.define(taskPublishPage, handler: Handler(handlerFunc: (_, params){
        String content = params['content'].first;
        return PublishTaskPage(content: content);
    }));
    router.define(taskDetailPage, handler: Handler(handlerFunc: (_, params){
        String taskId = params['taskId'].first;
        return TaskDetailPage(taskId: taskId);
    }));
    //router.define(auditResultPage, handler: Handler(handlerFunc: (_, params) => StoreAuditResultPage()));
    router.define(myCustomForm, handler: Handler(handlerFunc: (_, params) => MyCustomForm()));
    router.define(taskPublishEndPage, handler: Handler(handlerFunc: (_, params) => PublishTaskEndPage()));


    router.define(taskHomePage,handler: Handler(handlerFunc: (_,params) =>  TaskHomePage()));
    router.define(taskIssuesMessagePage,handler: Handler(handlerFunc: (_,params) =>  IssuesMessagePage()));
    router.define(taskPayPage, handler: Handler(handlerFunc: (_, params){
      String pay = params['pay'].first;
      String price = params['price'].first;
      return TaskPayPage(pay: pay,price: price);
    }));

    router.define(taskTypeChosePage,handler: Handler(handlerFunc: (_,params) =>  TaskTypeChosePage()));
  }
  
}