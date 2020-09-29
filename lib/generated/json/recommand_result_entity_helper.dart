import 'package:flutter_deer/task/models/recommand_result_entity.dart';

recommandResultEntityFromJson(RecommandResultEntity data, Map<String, dynamic> json) {
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
	if (json['state'] != null) {
		data.state = json['state']?.toInt();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['needpeoplenum'] != null) {
		data.needpeoplenum = json['needpeoplenum']?.toInt();
	}
	return data;
}

Map<String, dynamic> recommandResultEntityToJson(RecommandResultEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['userid'] = entity.userid;
	data['createTime'] = entity.createTime;
	data['title'] = entity.title;
	data['content'] = entity.content;
	data['workerPrice'] = entity.workerPrice;
	data['state'] = entity.state;
	data['username'] = entity.username;
	data['needpeoplenum'] = entity.needpeoplenum;
	return data;
}