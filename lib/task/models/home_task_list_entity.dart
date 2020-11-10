import 'package:flutter_deer/generated/json/base/json_convert_content.dart';

class HomeTaskListEntity with JsonConvert<HomeTaskListEntity> {
	int id;
	int userid;
	String createTime;
	String title;
	String content;
	double workerPrice;
	int needpeoplenum;
	int payStatus;
	int status;
	double needtotalpay;
	int typeid;
	String taskLimit;
	String applyEndTime;
	String workEndTime;
	int aduitTime;
	String orderid;
	List<HomeTaskListUserTaskList> userTaskList;
}

class HomeTaskListUserTaskList with JsonConvert<HomeTaskListUserTaskList> {
	int id;
	int userId;
	int businessTaskId;
	int userTaskStatus;

	dynamic userApplyTaskTime;
	dynamic businessAgreeApplyTime;
	dynamic userFirstSubmitTaskTime;
	dynamic userFirstSubmitTaskContent;
	dynamic businessAuditFirstTime;
	dynamic businessAuditFirstResult;
	dynamic userSecondSubmitTaskTime;
	dynamic userSecondSubmitTaskContent;
	dynamic businessAuditSecondTime;
	dynamic businessAuditSecondResult;
	dynamic userQuitTask;
	dynamic task;
	dynamic name;
}
