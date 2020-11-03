class UserEntity {

	int id;
	String mobile;
	double money;
	String name;
	String userToken;
	String avatar;


	UserEntity.fromJson(Map<String, dynamic> json) {

		id = json['id'];
		mobile=json['mobile'];
		money=json['money'];
		name = json['name'];
		userToken=json['userToken'];
		avatar = json['avatar'];
	}
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['mobile'] = this.mobile;
		data['money'] = this.money;
		data['name'] = this.name;
		data['userToken'] = this.userToken;
		data['avatar'] = this.avatar;
		return data;
	}
}
