import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/order/widgets/order_item.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Widget_RefreshIndicator_Page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Widget_RefreshIndicator_State();
  }

}

class Widget_RefreshIndicator_State extends State<Widget_RefreshIndicator_Page> {
  var list = [];
  int page = 0;
  bool isLoading = false;//是否正在请求新数据
  bool showMore = false;//是否显示底部加载中提示
  bool offState = false;//是否显示进入页面时的圆形进度条

  ScrollController scrollController = ScrollController();

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
    getListData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
            children: <Widget>[
              SafeArea(
                child: SizedBox(
                  height: 105,
                  width: double.infinity,
                  child: const DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: const [Color(0xFF5793FA), Color(0xFF4647FA)])
                      )
                  ),
                ),
              ),
              RefreshIndicator(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: list.length +1,//列表长度+底部加载中提示+header的长度
                  itemBuilder: choiceItemWidget,
                ),
                onRefresh: _onRefresh,
              ),
              Offstage(
                offstage: offState,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          )
      ),
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
        return buildHeader();
    } else if (position < list.length) {
//      return HomeListItem(position, list[position], (position) {
//        debugPrint("点击了第$position条");
//      });
      print("build_OrderItem");

      return OrderItem(key: Key('order_item_$position'), index: position, tabIndex: 0,);
    } else if (showMore) {
      return showMoreLoadingWidget();
    }else{
      return null;
    }
  }
  Widget buildHeader(){
    List<Image> imgs = [
      //建立了一个图片数组
      Image.network(
        "https://images.unsplash.com/photo-1477346611705-65d1883cee1e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
        fit: BoxFit.cover,
      ),
      Image.network(
        "https://images.unsplash.com/photo-1498550744921-75f79806b8a7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
        fit: BoxFit.cover,
      ),
      Image.network(
        "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
        fit: BoxFit.cover,
      ),
    ];
    return Container(
      height: 100,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          //条目构建函数传入了index,根据index索引到特定图片
          return imgs[index];
        },
        itemCount: imgs.length,
        autoplay: true,
        pagination: new SwiperPagination(), //这些都是控件默认写好的,直接用
        control: new SwiperControl( iconNext: null,iconPrevious: null),
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
    print("getListData");
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
        offState = true;
        list.add(ItemInfo("ListView的一行数据header"));
        list.addAll(List.generate(3, (i) {
          return ItemInfo("ListView的一行数据$i");
        }));

        print("list.length="+list.length.toString());
      });
    });
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
        list.add(ItemInfo("上拉添加ListView的一行数据header"));
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