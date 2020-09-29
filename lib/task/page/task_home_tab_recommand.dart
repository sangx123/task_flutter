import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/net/http_api.dart';
import 'package:flutter_deer/order/provider/order_page_provider.dart';
import 'package:flutter_deer/order/widgets/order_item.dart';
import 'package:flutter_deer/order/widgets/order_item_tag.dart';
import 'package:flutter_deer/order/widgets/order_list.dart';
import 'package:flutter_deer/task/models/recommand_result_entity.dart';
import 'package:flutter_deer/task/page/task_recommand_item.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/search_bar.dart';
import 'package:flutter_deer/widgets/state_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class TaskHomeReCommandPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TaskHomeReCommandStatePage();
  }
}

class TaskHomeReCommandStatePage extends State<TaskHomeReCommandPage>
    with
        AutomaticKeepAliveClientMixin<TaskHomeReCommandPage>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  var _list = [];
  bool isLoading = false; //是否正在请求新数据
  bool showMore = false; //是否显示底部加载中提示
  bool offState = false; //是否显示进入页面时的圆形进度条

  ScrollController scrollController = ScrollController();
  bool isDark = false;


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
                    hasMore: _page < _maxPage,
                    itemBuilder: (_, index) {
                      if (index == 0) {
                        return buildBanners();
                      } else{
                        print("build_TaskRecommandItemPage");
                        return TaskRecommandItemPage(
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

  buildBanners() {
    List<BannerItem> list = new List<BannerItem>();
    BannerItem item = BannerItem(
        id: "49984",
        pic:
            "https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3375017683,2174997570&fm=26&gp=0.jpg",
        link: "https://www.bilibili.com/blackboard/dynamic/3886",
        title: "第五人格画家重磅登场",
        position: "1");
    list.add(item);
    list.add(item);
    return Container(
      height: 100,
      margin: EdgeInsets.only(top: 10, bottom: 3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Swiper(
          autoplay: true,
          pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: DotSwiperPaginationBuilder(
              size: 7,
              activeSize: 7,
              color: Colors.white,
              activeColor: Theme.of(context).primaryColor,
            ),
          ),
          itemCount: list.length,
          itemBuilder: (context, i) {
            return Container(
              child: Image.network(
                list[i].pic,
                fit: BoxFit.fitWidth,
              ),
            );
          },
        ),
      ),
    );
  }
  /**
   * 模拟到底部加载更多数据
   */

  Future<void> _loadMore() async {
    print('上拉刷新开始,page = $_page');
    await DioUtils.instance.requestNetwork<RecommandResultEntity>(
        Method.post, HttpApi.getMyPublishTaskList, isList: true,
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
    }, params: {"pageSize": 5, "pageNumber": _page + 1, "state": 0});
  }

  ///下拉刷新
  Future<void> _onRefresh() async {
    //NavigatorUtils.push(context, StoreRouter.auditPage);
    await DioUtils.instance.requestNetwork<RecommandResultEntity>(
        Method.post, HttpApi.getMyPublishTaskList, isList: true, onSuccessList: (data) {
      setState(() {
        _page = 1;
        _list.clear();
        _list.add(0);
        _list.addAll(data);
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show(msg);
      });
    }, params: {"pageSize": 5, "pageNumber": 1, "state": 0});
  }
}

// 定义一个回调接口
typedef OnItemClickListener = void Function(int position);

class HomeListItem extends StatelessWidget {
  int position;
  ItemInfo iteminfo;
  OnItemClickListener listener;

  HomeListItem(this.position, this.iteminfo, this.listener);

  @override
  Widget build(BuildContext context) {
    var widget = Column(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    iteminfo.title,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xff999999),
                    ),
                  )
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          height: 50.0,
          color: Color.fromARGB(255, 241, 241, 241),
          padding: EdgeInsets.only(left: 20.0),
        ),
        //用Container设置分割线
        Container(
          height: 1.0,
          color: Color.fromARGB(255, 230, 230, 230),
        )
        //分割线
//      Divider()
      ],
    );
    //InkWell点击的时候有水波纹效果
    return InkWell(onTap: () => listener(position), child: widget);
  }
}

class ItemInfo {
  String title;

  ItemInfo(this.title);
}

class BannerItem {
  String pic;
  String id;
  String position;
  String title;
  String link;

  BannerItem({this.id, this.link, this.pic, this.position, this.title});

  BannerItem.fromJson(Map<String, dynamic> jsondata) {
    pic = jsondata["pic"];
    id = jsondata["id"];
    position = jsondata["position"];
    title = jsondata["title"];
    link = jsondata["link"];
  }
}

class Banners {
  List<BannerItem> list;

  Banners();

  Banners.fromJson(Map<String, dynamic> jd) {
    list = List<BannerItem>();
    for (Map<String, dynamic> item in jd["banner"]) {
      list.add(BannerItem.fromJson(item));
    }
  }
}
