import 'package:flutter_deer/shop/models/my_jie_shou_entity.dart';

myJieShouEntityFromJson(MyJieShouEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toInt();
	}
	if (json['businessTaskId'] != null) {
		data.businessTaskId = json['businessTaskId']?.toInt();
	}
	if (json['userTaskStatus'] != null) {
		data.userTaskStatus = json['userTaskStatus']?.toInt();
	}
	if (json['userApplyTaskTime'] != null) {
		data.userApplyTaskTime = json['userApplyTaskTime']?.toString();
	}
	if (json['businessAgreeApplyTime'] != null) {
		data.businessAgreeApplyTime = json['businessAgreeApplyTime']?.toString();
	}
	if (json['userFirstSubmitTaskTime'] != null) {
		data.userFirstSubmitTaskTime = json['userFirstSubmitTaskTime'];
	}
	if (json['userFirstSubmitTaskContent'] != null) {
		data.userFirstSubmitTaskContent = json['userFirstSubmitTaskContent'];
	}
	if (json['businessAuditFirstTime'] != null) {
		data.businessAuditFirstTime = json['businessAuditFirstTime'];
	}
	if (json['businessAuditFirstResult'] != null) {
		data.businessAuditFirstResult = json['businessAuditFirstResult'];
	}
	if (json['userSecondSubmitTaskTime'] != null) {
		data.userSecondSubmitTaskTime = json['userSecondSubmitTaskTime'];
	}
	if (json['userSecondSubmitTaskContent'] != null) {
		data.userSecondSubmitTaskContent = json['userSecondSubmitTaskContent'];
	}
	if (json['businessAuditSecondTime'] != null) {
		data.businessAuditSecondTime = json['businessAuditSecondTime'];
	}
	if (json['businessAuditSecondResult'] != null) {
		data.businessAuditSecondResult = json['businessAuditSecondResult'];
	}
	if (json['userQuitTask'] != null) {
		data.userQuitTask = json['userQuitTask'];
	}
	if (json['task'] != null) {
		data.task = new MyJieShouTask().fromJson(json['task']);
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	return data;
}

Map<String, dynamic> myJieShouEntityToJson(MyJieShouEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['userId'] = entity.userId;
	data['businessTaskId'] = entity.businessTaskId;
	data['userTaskStatus'] = entity.userTaskStatus;
	data['userApplyTaskTime'] = entity.userApplyTaskTime;
	data['businessAgreeApplyTime'] = entity.businessAgreeApplyTime;
	data['userFirstSubmitTaskTime'] = entity.userFirstSubmitTaskTime;
	data['userFirstSubmitTaskContent'] = entity.userFirstSubmitTaskContent;
	data['businessAuditFirstTime'] = entity.businessAuditFirstTime;
	data['businessAuditFirstResult'] = entity.businessAuditFirstResult;
	data['userSecondSubmitTaskTime'] = entity.userSecondSubmitTaskTime;
	data['userSecondSubmitTaskContent'] = entity.userSecondSubmitTaskContent;
	data['businessAuditSecondTime'] = entity.businessAuditSecondTime;
	data['businessAuditSecondResult'] = entity.businessAuditSecondResult;
	data['userQuitTask'] = entity.userQuitTask;
	if (entity.task != null) {
		data['task'] = entity.task.toJson();
	}
	data['name'] = entity.name;
	return data;
}

myJieShouTaskFromJson(MyJieShouTask data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['userid'] != null) {
		data.userid = json['userid']?.toInt();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['content'] != null) {
		data.content = json['content']?.toString();
	}
	if (json['workerPrice'] != null) {
		data.workerPrice = json['workerPrice']?.toDouble();
	}
	if (json['needpeoplenum'] != null) {
		data.needpeoplenum = json['needpeoplenum']?.toInt();
	}
	if (json['payStatus'] != null) {
		data.payStatus = json['payStatus']?.toInt();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['needtotalpay'] != null) {
		data.needtotalpay = json['needtotalpay']?.toDouble();
	}
	if (json['typeid'] != null) {
		data.typeid = json['typeid']?.toInt();
	}
	if (json['taskLimit'] != null) {
		data.taskLimit = json['taskLimit']?.toString();
	}
	if (json['applyEndTime'] != null) {
		data.applyEndTime = json['applyEndTime']?.toString();
	}
	if (json['workEndTime'] != null) {
		data.workEndTime = json['workEndTime']?.toString();
	}
	if (json['aduitTime'] != null) {
		data.aduitTime = json['aduitTime']?.toInt();
	}
	if (json['orderid'] != null) {
		data.orderid = json['orderid']?.toString();
	}
	if (json['userTaskList'] != null) {
		data.userTaskList = json['userTaskList'];
	}
	return data;
}

Map<String, dynamic> myJieShouTaskToJson(MyJieShouTask entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['userid'] = entity.userid;
	data['createTime'] = entity.createTime;
	data['title'] = entity.title;
	data['content'] = entity.content;
	data['workerPrice'] = entity.workerPrice;
	data['needpeoplenum'] = entity.needpeoplenum;
	data['payStatus'] = entity.payStatus;
	data['status'] = entity.status;
	data['needtotalpay'] = entity.needtotalpay;
	data['typeid'] = entity.typeid;
	data['taskLimit'] = entity.taskLimit;
	data['applyEndTime'] = entity.applyEndTime;
	data['workEndTime'] = entity.workEndTime;
	data['aduitTime'] = entity.aduitTime;
	data['orderid'] = entity.orderid;
	data['userTaskList'] = entity.userTaskList;
	return data;
}