
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/router_init.dart';
import 'package:flutter_deer/shop/page/feedback.dart';
import 'package:flutter_deer/shop/page/my_fabu_task_manager_home.dart';
import 'package:flutter_deer/shop/page/my_fabu_user_task_manager_home.dart';
import 'package:flutter_deer/shop/page/my_jieshou_task_manager_home.dart';
import 'package:flutter_deer/shop/page/user_apply_info_page.dart';

import 'page/freight_config_page.dart';
import 'page/message_page.dart';
import 'page/select_address_page.dart';
import 'page/shop_page.dart';
import 'page/shop_setting_page.dart';

class ShopRouter implements IRouterProvider{

  static String shopPage = "/shop";
  static String shopSettingPage = "/shop/shopSetting";
  static String messagePage = "/shop/message";
  static String freightConfigPage = "/shop/freightConfig";
  static String addressSelectPage = "/shop/addressSelect";
  static String feedbackPage = "/shop/feedback";
  static String myFabuTaskManagerHome = "/shop/myFabuTaskManagerHome";
  static String myJieshouTaskManagerHome = "/shop/myJieshouTaskManagerHome";
  static String myFabuUserTaskManagerHome = "/shop/myFabuUserTaskManagerHome";
  ///用户申请详情页-展示用户的一些基本信息，以及同意,忽略按钮
  static String userApplyInfoPage = "/shop/userApplyInfoPage";


  @override
  void initRouter(Router router) {
    router.define(shopPage, handler: Handler(handlerFunc: (_, params) => ShopPage()));
    router.define(shopSettingPage, handler: Handler(handlerFunc: (_, params) => ShopSettingPage()));
    router.define(messagePage, handler: Handler(handlerFunc: (_, params) => MessagePage()));
    router.define(freightConfigPage, handler: Handler(handlerFunc: (_, params) => FreightConfigPage()));
    router.define(addressSelectPage, handler: Handler(handlerFunc: (_, params) => AddressSelectPage()));
    router.define(feedbackPage, handler: Handler(handlerFunc: (_, params) => FeedBackPage()));
    router.define(myFabuTaskManagerHome, handler: Handler(handlerFunc: (_, params) => MyFabuTaskManagerHome()));
    router.define(myJieshouTaskManagerHome, handler: Handler(handlerFunc: (_, params) => MyJieshouTaskManagerHome()));
    router.define(myFabuUserTaskManagerHome, handler:  Handler(handlerFunc: (_, params){
      String taskId = params['taskId'].first;
      return MyFabuUserTaskManagerHome(taskId: int.parse(taskId));
    }));

    router.define(userApplyInfoPage, handler:  Handler(handlerFunc: (_, params){
      String userTaskId=params['userTaskId'].first;
      return UserApplyInfoPage(userTaskId:userTaskId);
    }));
  }
}