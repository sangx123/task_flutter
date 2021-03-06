
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/router_init.dart';
import 'package:flutter_deer/shop/page/feedback.dart';
import 'package:flutter_deer/shop/page/my_fabu_task_manager_home.dart';
import 'package:flutter_deer/shop/page/my_fabu_user_task_manager_home.dart';
import 'package:flutter_deer/shop/page/my_jieshou_task_manager_home.dart';
import 'package:flutter_deer/shop/page/user_apply_info_page.dart';
import 'package:flutter_deer/shop/page/user_first_audit_fail_page.dart';
import 'package:flutter_deer/shop/page/user_first_audit_fail_submit_page.dart';

import 'page/business_first_audit_fail_reason.dart';
import 'page/business_first_audit_page.dart';
import 'page/business_second_audit_fail_reason.dart';
import 'page/business_second_audit_page.dart';
import 'page/freight_config_page.dart';
import 'page/message_page.dart';
import 'page/my_jieshou_tijiao.dart';
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
  static String myJieShouTiJiaoPage = "/shop/myJieShouTiJiaoPage";


  static String businessFirstAduitPage = "/shop/businessFirstAduitPage";
  static String businessFirstAuditFailReasonPage = "/shop/businessFirstAuditFailReasonPage";

  static String userFirstAuditFailPage = "/shop/userFirstAuditFailPage";
  static String userFirstAuditFailSubmitPage = "/shop/userFirstAuditFailSubmitPage";


  static String businessSecondAduitPage = "/shop/businessSecondAduitPage";
  static String businessSecondAuditFailReasonPage = "/shop/businessSecondAuditFailReasonPage";


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

    router.define(myJieShouTiJiaoPage, handler:  Handler(handlerFunc: (_, params){
      String contents="";
      String userTaskId=params['userTaskId'].first;
      if(params['contents']!=null)
        contents=params['contents'].first;
      return MyJieShouTiJiaoPage(userTaskId:userTaskId,content: contents);
    }));


    router.define(businessFirstAduitPage, handler:  Handler(handlerFunc: (_, params){
      String userTaskId="";
      if(params['userTaskId']!=null)
        userTaskId=params['userTaskId'].first;
      return BusinessFirstAduitPage(userTaskId:userTaskId);
    }));

    router.define(businessFirstAuditFailReasonPage, handler:  Handler(handlerFunc: (_, params){
      String userTaskId="";
      if(params['userTaskId']!=null)
        userTaskId=params['userTaskId'].first;
      return BusinessFirstAuditFailReasonPage(userTaskId:userTaskId);
    }));


    router.define(userFirstAuditFailPage, handler:  Handler(handlerFunc: (_, params){
      String userTaskId="";
      if(params['userTaskId']!=null)
        userTaskId=params['userTaskId'].first;
      return UserFirstAuditFailPage(userTaskId:userTaskId);
    }));



    router.define(userFirstAuditFailSubmitPage, handler:  Handler(handlerFunc: (_, params){
      String userTaskId="";
      if(params['userTaskId']!=null)
        userTaskId=params['userTaskId'].first;
      return UserFirstAuditFailSubmitPage(userTaskId:userTaskId);
    }));


    router.define(businessSecondAduitPage, handler:  Handler(handlerFunc: (_, params){
      String userTaskId="";
      if(params['userTaskId']!=null)
        userTaskId=params['userTaskId'].first;
      return BusinessSecondAduitPage(userTaskId:userTaskId);
    }));



    router.define(businessSecondAuditFailReasonPage, handler:  Handler(handlerFunc: (_, params){
      String userTaskId="";
      if(params['userTaskId']!=null)
        userTaskId=params['userTaskId'].first;
      return BusinessSecondAuditFailReasonPage(userTaskId:userTaskId);
    }));

  }
}