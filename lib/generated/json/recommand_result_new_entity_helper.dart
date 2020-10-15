import 'package:flutter_deer/task/models/recommand_result_new_entity.dart';

recommandResultNewEntityFromJson(RecommandResultNewEntity data, Map<String, dynamic> json) {
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
	return data;
}

Map<String, dynamic> recommandResultNewEntityToJson(RecommandResultNewEntity entity) {
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
	return data;
}