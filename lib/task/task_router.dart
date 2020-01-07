
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/router_init.dart';
import 'package:flutter_deer/task/page/task_publish.dart';

import 'page/test_forcus.dart';


class TaskRouter implements IRouterProvider{

  static String taskPublishPage = "/task/taskPublish";
  static String myCustomForm = "/store/MyCustomForm";
  
  @override
  void initRouter(Router router) {
    router.define(taskPublishPage, handler: Handler(handlerFunc: (_, params) => PublishTaskPage()));
    //router.define(auditResultPage, handler: Handler(handlerFunc: (_, params) => StoreAuditResultPage()));
    router.define(myCustomForm, handler: Handler(handlerFunc: (_, params) => MyCustomForm()));

  }
  
}