
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/home/provider/home_provider.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';
import 'package:flutter_deer/task/page/task_home.dart';
import 'package:flutter_deer/task/task_router.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _pageList;
  
  var _appBarTitles = ['首页', "发布", '我的'];
  final _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem> _list;
  List<BottomNavigationBarItem> _listDark;

  @override
  void initState() {
    super.initState();
    initData();
  }
  
  void initData(){
    _pageList = [
      //OrderPage(),
      TaskHomePage(),
      //GoodsPage(),
      Text(""),
      //StatisticsPage(),
      ShopPage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem(){
    if (_list == null){
      var _tabImages = [
        [
          const LoadAssetImage("home/icon_order", width: 25.0, color: Colours.unselected_item_color,),
          const LoadAssetImage("home/icon_order", width: 25.0, color: Colours.app_main,),
        ],
//        [
//          const LoadAssetImage("home/icon_commodity", width: 25.0, color: Colours.unselected_item_color,),
//          const LoadAssetImage("home/icon_commodity", width: 25.0, color: Colours.app_main,),
//        ],
        [
          const LoadAssetImage("home/icon_statistics", width: 25.0, color: Colours.unselected_item_color,),
          const LoadAssetImage("home/icon_statistics", width: 25.0, color: Colours.app_main,),
        ],
//        [
//          const LoadAssetImage("home/icon_statistics", width: 25.0, color: Colours.unselected_item_color,),
//          const LoadAssetImage("home/icon_statistics", width: 25.0, color: Colours.app_main,),
//        ],
        [
          const LoadAssetImage("home/icon_shop", width: 25.0, color: Colours.unselected_item_color,),
          const LoadAssetImage("home/icon_shop", width: 25.0, color: Colours.app_main,),
        ]
      ];
      _list = List.generate(3, (i){
        return BottomNavigationBarItem(
            icon: _tabImages[i][0],
            activeIcon: _tabImages[i][1],
            title: Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: Text(_appBarTitles[i], key: Key(_appBarTitles[i]),),
            )
        );
      });
    }
    return _list;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem(){
    if (_listDark == null){
      var _tabImagesDark = [
        [
          const LoadAssetImage("home/icon_order", width: 25.0),
          const LoadAssetImage("home/icon_order", width: 25.0, color: Colours.dark_app_main,),
        ],
//        [
//          const LoadAssetImage("home/icon_commodity", width: 25.0),
//          const LoadAssetImage("home/icon_commodity", width: 25.0, color: Colours.dark_app_main,),
//        ],
        [
          const LoadAssetImage("home/icon_statistics", width: 25.0),
          const LoadAssetImage("home/icon_statistics", width: 25.0, color: Colours.dark_app_main,),
        ],
//        [
//          const LoadAssetImage("home/icon_statistics", width: 25.0),
//          const LoadAssetImage("home/icon_statistics", width: 25.0, color: Colours.dark_app_main,),
//        ],
        [
          const LoadAssetImage("home/icon_shop", width: 25.0),
          const LoadAssetImage("home/icon_shop", width: 25.0, color: Colours.dark_app_main,),
        ]
      ];

      _listDark = List.generate(3, (i){
        return BottomNavigationBarItem(
            icon: _tabImagesDark[i][0],
            activeIcon: _tabImagesDark[i][1],
            title: Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: Text(_appBarTitles[i], key: Key(_appBarTitles[i]),),
            )
        );
      });
    }
    return _listDark;
  }

  DateTime  _lastTime;
  Future<bool> _isExit(){
    if (_lastTime == null || DateTime.now().difference(_lastTime) > Duration(milliseconds: 2500)) {
      _lastTime = DateTime.now();
      Toast.show("再次点击退出应用");
      return Future.value(false);
    } 
    Toast.cancelToast();
    return Future.value(true);
  }
  final _widgetOptionsAppBar = [SearchBar(
    hintText: "请输入商品名称查询",
    onPressed: (text){
    Toast.show("搜索内容：$text");
    },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: WillPopScope(//WillPopScope双击返回应用
        onWillPop: _isExit,
        child: Scaffold(
          appBar: provider.value==0?_widgetOptionsAppBar.elementAt(provider.value):null,
          bottomNavigationBar: Consumer<HomeProvider>(
            builder: (_, provider, __){
              return BottomNavigationBar(
                backgroundColor: ThemeUtils.getBackgroundColor(context),
                items: isDark ? _buildDarkBottomNavigationBarItem() : _buildBottomNavigationBarItem(),
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation: 5.0,
                iconSize: 21.0,
                selectedFontSize: Dimens.font_sp10,
                unselectedFontSize: Dimens.font_sp10,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: isDark ? Colours.dark_unselected_item_color : Colours.unselected_item_color,
                onTap: (index) =>{
                   if(index!=1)
                  _pageController.jumpToPage(index)
                },
              );
            },
          ),
          // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pageList,
            physics: NeverScrollableScrollPhysics(), // 禁止滑动
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(top: 8),
            width: 55,
            height: 55,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55),
                color: Color.fromRGBO(246, 246, 246, 1.0)
            ),

            child: FloatingActionButton(

              elevation: 0,
              focusElevation: 0,

              onPressed: (){

                NavigatorUtils.push(context, TaskRouter.taskPublishEndPage);
                //NavigatorUtils.goWebViewPage(context, "发布任务", "http://192.168.0.127:8081/#/pages/index/richtext");
              },
              child: Icon(Icons.add,size: 25,color: Colors.white,),
              //backgroundColor: Color.fromRGBO(253, 219, 69, 1.0),
                backgroundColor: Color.fromRGBO(70, 136, 250, 1.0),
            ),

          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    provider.value = index;
    setState(() {

    });
  }

}
