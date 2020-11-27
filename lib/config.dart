
import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/shop_router.dart';
import 'package:flutter_deer/task/models/home_task_list_entity.dart';

class Config{

  static String  getTaskStatus(String status) {
    String result = "";
    if(status==null)
      return result;
    switch (status) {
      case "0":
        result = "申请中";
        break;
      case "1":
        result = "用户待提交";
        break;
      case "2":
        result = "用户待提交超时";
        break;
      case "3":
        result = "用户已提交待审核";
        break;
      case "4":
        result = "商户审核超时";
        break;
      case "5":
        result = "商户审核成功";
        break;
      case "6":
        result = "商户审核失败";
        break;
      case "7":
        result = "用户申诉中";
        break;
      case "8":
        result = "商户申诉审核超时";
        break;
      case "9":
        result = "商户申诉审核成功";
        break;
      case "10":
        result = "商户申诉审核失败";
        break;
    }
    return result;
  }


  static String getTaskStatusTime(HomeTaskListUserTaskList model) {
    String result = "";
    if(model==null)
      return result;
    switch (model.userTaskStatus.toString()) {
      case "0":
        result = "任务申请时间: "+model.userApplyTaskTime;
        break;
      case "1":
        result = "任务开始时间: "+model.businessAgreeApplyTime;
        break;
      case "2":
        result = "任务开始时间: "+model.businessAgreeApplyTime;
        break;
      case "3":
        result = "用户提交审核时间: "+model.userFirstSubmitTaskTime;
        break;
      case "4":
        result = "用户提交审核时间: "+model.userFirstSubmitTaskTime;
        break;
      case "5":
        result = "商户审核时间: "+model.businessAuditFirstTime;
        break;
      case "6":
        result = "商户审核时间: "+model.businessAuditFirstTime;
        break;
      case "7":
        result = "用户提交申诉时间: "+model.userSecondSubmitTaskTime;
        break;
      case "8":
        result = "用户提交申诉时间: "+model.userSecondSubmitTaskTime;;
        break;
      case "9":
        result = "商户申诉审核时间: "+model.businessAuditSecondTime;
        break;
      case "10":
        result ="商户申诉审核时间: "+model.businessAuditSecondTime;;
        break;
    }
    return result;
  }


  static void goNext(BuildContext context,HomeTaskListUserTaskList model) {

    switch (model.userTaskStatus.toString()) {
      case "0":
       //跳转到任务申请通过界面（business角色）
        NavigatorUtils.push(context, '${ShopRouter.userApplyInfoPage}?userTaskId=${model.id}');
        break;
      case "1":
      //跳转到用户待提交界面（user角色）
        NavigatorUtils.push(context, '${ShopRouter.myJieShouTiJiaoPage}?userTaskId=${model.id}');
        break;
      case "2":
        //用户待提交超时
        break;
      case "3":
        //商户审核界面
        NavigatorUtils.push(context, '${ShopRouter.businessFirstAduitPage}?userTaskId=${model.id}');
        break;
      case "4":

        break;
      case "5":
        //审核成功不需要跳转
        break;
      case "6":
        //用户查看申诉失败界面
        NavigatorUtils.push(context, '${ShopRouter.userFirstAuditFailPage}?userTaskId=${model.id}');
        break;
      case "7":
        //商户点击跳转到审核界面
        NavigatorUtils.push(context, '${ShopRouter.businessSecondAduitPage}?userTaskId=${model.id}');
        break;
      case "8":

        break;
      case "9":

        break;
      case "10":

        break;
    }
  }
}