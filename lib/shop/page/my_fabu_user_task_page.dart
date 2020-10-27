import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/net/http_api.dart';
import 'package:flutter_deer/order/provider/order_page_provider.dart';
import 'package:flutter_deer/order/widgets/order_item.dart';
import 'package:flutter_deer/order/widgets/order_item_tag.dart';
import 'package:flutter_deer/order/widgets/order_list.dart';
import 'package:flutter_deer/task/models/home_task_list_entity.dart';
import 'package:flutter_deer/task/models/recommand_result_new_entity.dart';
import 'package:flutter_deer/task/page/task_recommand_item.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/search_bar.dart';
import 'package:flutter_deer/widgets/state_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import 'my_fabu_task_item.dart';
import 'my_fabu_user_task_item.dart';


///我发布任务管理首页---已进行的任务列表，已结束的任务列表
class MyFabuUserTaskPage extends StatefulWidget {
  //3是未完成，4是已完成
  const MyFabuUserTaskPage({Key key, this.status,this.taskId}) : super(key: key);

  final int status;
  final int taskId;
  @override
  State<StatefulWidget> createState() {
    return _MyFabuUserTaskPageState();
  }
}

class _MyFabuUserTaskPageState extends State<MyFabuUserTaskPage>
    with
        AutomaticKeepAliveClientMixin<MyFabuUserTaskPage>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  var _list = [];
  bool isLoading = false; //是否正在请求新数据
  bool showMore = false; //是否显示底部加载中提示
  bool offState = false; //是否显示进入页面时的圆形进度条

  ScrollController scrollController = ScrollController();
  bool isDark = false;
  bool showEmpty;

  int _page = 1;
  int _maxPage=2;
  StateType _stateType = StateType.loading;


  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    isDark = ThemeUtils.isDark(context);
    return Scaffold(
        backgroundColor: Color(0xFFF1F1F1),
        body: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: DeerListView(
                    itemCount: _list.length,
                    stateType: _stateType,
                    onRefresh: _onRefresh,
                    loadMore: _loadMore,
                    hasMore: false,
                    itemBuilder: (_, index) {
                        print("build_TaskRecommandItemPage");
                        if(showEmpty){
                            return Container();
                        }else{
                          return MyFabuUserTaskItemPage(
                              key: Key('order_item_$index'),
                              index: index,
                              tabIndex: 0,
                              model: _list[index]);
                        }
                    })),
        );
  }

  @override
  void dispose() {
    super.dispose();
    //手动停止滑动监听
    scrollController.dispose();
  }

  /**
   * 模拟到底部加载更多数据
   */

  Future<void> _loadMore() async {
    print('上拉刷新开始,page = $_page');
    await DioUtils.instance.requestNetwork<HomeTaskListUserTaskList>(
        Method.post, HttpApi.getMyPublishUserTask, isList: true,
        onSuccessList: (data) {
      setState(() {
        if(data.isNotEmpty) {
          _list.addAll(data);
          _page++;
          _maxPage = _page + 1;
        }else{
          _maxPage = _page ;
        }
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show(msg);
      });
    }, params: {"pageSize": 10, "pageNumber": _page + 1, "status": widget.status,"taskId": widget.taskId});
  }

  ///下拉刷新
  Future<void> _onRefresh() async {
    //NavigatorUtils.push(context, StoreRouter.auditPage);
    await DioUtils.instance.requestNetwork<HomeTaskListUserTaskList>(
        Method.post, HttpApi.getMyPublishUserTask, isList: true, onSuccessList: (data) {
      setState(() {


        if(data.isNotEmpty) {
          showEmpty=false;
          _page = 1;
          _list.clear();
          _list.addAll(data);
          if(_list.length<10){
            _maxPage = _page ;
          }
        }else{
          _maxPage=1;
          showEmpty=true;
          _list.add(0);
        }

      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show(msg);
      });
    }, params: {"pageSize": 10, "pageNumber": 1, "status": widget.status,"taskId": widget.taskId});
  }
}

// 定义一个回调接口
typedef OnItemClickListener = void Function(int position);
