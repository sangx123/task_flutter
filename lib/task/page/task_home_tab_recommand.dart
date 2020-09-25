
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/net/http_api.dart';
import 'package:flutter_deer/order/provider/order_page_provider.dart';
import 'package:flutter_deer/order/widgets/order_item.dart';
import 'package:flutter_deer/order/widgets/order_item_tag.dart';
import 'package:flutter_deer/order/widgets/order_list.dart';
import 'package:flutter_deer/task/page/recommand_result_entity.dart';
import 'package:flutter_deer/task/page/task_recommand_item.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/search_bar.dart';
import 'package:flutter_deer/widgets/state_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
class TaskHomeReCommandPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new TaskHomeReCommandStatePage();
  }

}

class TaskHomeReCommandStatePage extends State<TaskHomeReCommandPage> with AutomaticKeepAliveClientMixin<TaskHomeReCommandPage>, SingleTickerProviderStateMixin{
  @override
  bool get wantKeepAlive => true;
  var list = [];
  int page = 0;
  bool isLoading = false;//是否正在请求新数据
  bool showMore = false;//是否显示底部加载中提示
  bool offState = false;//是否显示进入页面时的圆形进度条

  ScrollController scrollController = ScrollController();
  bool isDark = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('滑动到了最底部${scrollController.position.pixels}');
        setState(() {
          showMore = true;
        });
        getMoreData();
      }
    });
    //listview根据list的个数显示数据，所以添加header的话要增加1条数据，来显示项数
    list.add("header");
    getListData();
  }


  @override
  Widget build(BuildContext context) {

    isDark = ThemeUtils.isDark(context);
    return Scaffold(
           backgroundColor: Color(0xFFF1F1F1),
          body: Stack(

            children: <Widget>[
//              SafeArea(
//                child: SizedBox(
//                  height: 105,
//                  width: double.infinity,
//                  child: isDark ? null : const DecoratedBox(
//                      decoration: BoxDecoration(
//                          gradient: LinearGradient(colors: const [Color(0xFF5793FA), Color(0xFF4647FA)])
//                      )
//                  ),
//                ),
//              ),
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10),

              child:  RefreshIndicator(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: list.length + 1,//列表长度+底部加载中提示
                  itemBuilder: choiceItemWidget,
                  physics: new AlwaysScrollableScrollPhysics(),
                ),
                onRefresh: _onRefresh,

              ),),
              Offstage(
                offstage: offState,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          )
      );
  }

  @override
  void dispose() {
    super.dispose();
    //手动停止滑动监听
    scrollController.dispose();
  }

  /**
   * 加载哪个子组件
   */
  Widget choiceItemWidget(BuildContext context, int position) {
    print("choiceItemWidget position=="+position.toString()+",list.length="+list.length.toString());
    if(position==0){

        return buildBanners();
    } else if (position < list.length) {
         print("build_TaskRecommandItemPage");
//      return HomeListItem(position, list[position], (position) {
//        debugPrint("点击了第$position条");
//      });

      return TaskRecommandItemPage(key: Key('order_item_$position'), index: position, tabIndex: 0,model: list[position]);
    } else if (showMore) {
      return showMoreLoadingWidget();
    }else{
      return null;
    }
  }
  buildBanners()   {
    List<BannerItem> list=new List<BannerItem>();
    BannerItem item=BannerItem(id: "49984", pic: "https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3375017683,2174997570&fm=26&gp=0.jpg", link: "https://www.bilibili.com/blackboard/dynamic/3886", title: "第五人格画家重磅登场", position:"1" );
    list.add(item);
    list.add(item);
    return Container(
      height: 100,
      margin: EdgeInsets.only(top: 10,bottom: 3),
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
   * 加载更多提示组件
   */
  Widget showMoreLoadingWidget() {
    return Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('加载中...', style: TextStyle(fontSize: 16.0),),
        ],
      ),
    );
  }

  /**
   * 模拟进入页面获取数据
   */
  void getListData() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    //NavigatorUtils.push(context, StoreRouter.auditPage);
    await DioUtils.instance.requestNetwork<RecommandResultEntity>(
      Method.post, HttpApi.getMyPublishTaskList,isList: true,
      onSuccess: (data){
        setState(() {
          isLoading = false;
          offState = true;
        });
      },
        onSuccessList: (data){
          setState(() {
            isLoading = false;
            offState = true;
            list.addAll(data);
            print(list.length+1);
          });
        },
      onError: (code,msg){
        setState(() {
          isLoading = false;
          offState = true;
          Toast.show(msg);
        });
      },
      params: {}
    );
  }

  /**
   * 模拟到底部加载更多数据
   */
  void getMoreData() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
      page++;
    });
    print('上拉刷新开始,page = $page');
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
        showMore = false;
        list.addAll(List.generate(3, (i) {
          return ItemInfo("上拉添加ListView的一行数据$i");
        }));
        print('上拉刷新结束,page = $page');
      });
    });
  }

  /**
   * 模拟下拉刷新
   */
  Future < void > _onRefresh() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
      page = 0;
    });

    print('下拉刷新开始,page = $page');

    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;

        List tempList = List.generate(3, (i) {
          return ItemInfo("下拉添加ListView的一行数据$i");
        });
        tempList.addAll(list);
        list = tempList;
        print('下拉刷新结束,page = $page');
      });
    });
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

class BannerItem{
  String pic;
  String id;
  String position;
  String title;
  String link;
  BannerItem({this.id,this.link,this.pic,this.position,this.title});
  BannerItem.fromJson(Map<String ,dynamic> jsondata){
    pic=jsondata["pic"];
    id=jsondata["id"];
    position=jsondata["position"];
    title=jsondata["title"];
    link=jsondata["link"];
  }
}
class Banners{
  List<BannerItem> list;
  Banners();
  Banners.fromJson(Map<String,dynamic> jd){
    list=List<BannerItem>();
    for(Map<String,dynamic> item in jd["banner"]){
      list.add(BannerItem.fromJson(item));
    }
  }
}

