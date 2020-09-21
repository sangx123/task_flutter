
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/router_init.dart';
import 'package:flutter_deer/task/page/task_detail.dart';
import 'package:flutter_deer/task/page/task_home.dart';
import 'package:flutter_deer/task/page/task_publish.dart';
import 'package:flutter_deer/task/page/task_publish_end.dart';

import 'page/test_forcus.dart';


class TaskRouter implements IRouterProvider{

  static String taskPublishPage = "/task/taskPublish";
  static String taskHomePage = "/task/taskHome";
  static String taskPublishEndPage = "/task/taskPublishEnd";
  static String taskDetailPage = "/task/taskDetail";
  static String myCustomForm = "/store/MyCustomForm";
  @override
  void initRouter(Router router) {
    router.define(taskPublishPage, handler: Handler(handlerFunc: (_, params) => PublishTaskPage()));
    router.define(taskDetailPage, handler: Handler(handlerFunc: (_, params) => TaskDetailPage()));
    //router.define(auditResultPage, handler: Handler(handlerFunc: (_, params) => StoreAuditResultPage()));
    router.define(myCustomForm, handler: Handler(handlerFunc: (_, params) => MyCustomForm()));
    router.define(taskPublishEndPage, handler: Handler(handlerFunc: (_, params) => PublishTaskEndPage()));


    router.define(taskHomePage,handler: Handler(handlerFunc: (_,params) =>  TaskHomePage()));

  }
  
}