import 'package:flutter_deer/net/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
	if (json['userToken'] != null) {
		data.userToken = json['userToken']?.toString();
	}
	if (json['state'] != null) {
		data.state = json['state']?.toInt();
	}
	if (json['money'] != null) {
		data.money = json['money']?.toDouble();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	return data;
}

Map<String, dynamic> loginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['userToken'] = entity.userToken;
	data['state'] = entity.state;
	data['money'] = entity.money;
	data['id'] = entity.id;
	return data;
}