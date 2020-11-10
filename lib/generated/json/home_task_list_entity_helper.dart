import 'package:flutter_deer/task/models/home_task_list_entity.dart';

homeTaskListEntityFromJson(HomeTaskListEntity data, Map<String, dynamic> json) {
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
		data.userTaskList = new List<HomeTaskListUserTaskList>();
		(json['userTaskList'] as List).forEach((v) {
			data.userTaskList.add(new HomeTaskListUserTaskList().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> homeTaskListEntityToJson(HomeTaskListEntity entity) {
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
	if (entity.userTaskList != null) {
		data['userTaskList'] =  entity.userTaskList.map((v) => v.toJson()).toList();
	}
	return data;
}

homeTaskListUserTaskListFromJson(HomeTaskListUserTaskList data, Map<String, dynamic> json) {
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
		data.userApplyTaskTime = json['userApplyTaskTime'];
	}
	if (json['businessAgreeApplyTime'] != null) {
		data.businessAgreeApplyTime = json['businessAgreeApplyTime'];
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
		data.task = json['task'];
	}
	if (json['name'] != null) {
		data.name = json['name'];
	}
	return data;
}

Map<String, dynamic> homeTaskListUserTaskListToJson(HomeTaskListUserTaskList entity) {
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
	data['task'] = entity.task;
	data['name'] = entity.name;
	return data;
}