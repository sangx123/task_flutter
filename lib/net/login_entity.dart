import 'package:flutter_deer/generated/json/base/json_convert_content.dart';

class LoginEntity with JsonConvert<LoginEntity> {
	String userToken;
	int state;
	double money;
	String id;
}
