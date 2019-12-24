
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/provider/goods_page_provider.dart';
import 'package:flutter_deer/goods/widgets/goods_list.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/popup_window.dart';
import 'package:provider/provider.dart';

import '../goods_router.dart';


/// design/4商品/index.html
class GoodsPage extends StatefulWidget {
  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  List<String> _sortList = ["全部商品", "个人护理", "饮料", "沐浴洗护", "厨房用具", "休闲食品", "生鲜水果", "酒水", "家庭清洁"];
  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);

  var _sortIndex = 0;
  
  GlobalKey _addKey = GlobalKey();
  GlobalKey _bodyKey = GlobalKey();
  GlobalKey _buttonKey = GlobalKey();

  GoodsPageProvider provider = GoodsPageProvider();
  
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    return ChangeNotifierProvider<GoodsPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: (){
                NavigatorUtils.push(context, GoodsRouter.goodsSearchPage);
              },
              icon: LoadAssetImage(
                "goods/search",
                key: const Key('search'),
                width: 24.0,
                height: 24.0,
                color: _iconColor,
              ),
            ),
            IconButton(
              key: _addKey,
              onPressed: (){
                _showAddMenu();
              },
              icon: LoadAssetImage(
                "goods/add",
                key: const Key('add'),
                width: 24.0,
                height: 24.0,
                color: _iconColor,
              ),
            )
          ],
        ),
        body: Column(
          key: _bodyKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              key: _buttonKey,
              child: Consumer<GoodsPageProvider>(
                builder: (_, provider, __){
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                        child: Text(
                          _sortList[_sortIndex],
                          style: TextStyles.textBold24,
                        ),
                      ),
                      LoadAssetImage("goods/expand", width: 16.0, height: 16.0, color: _iconColor,)
                    ],
                  );
                },
              ),
              onTap: () => _showSortMenu(),
            ),
            Gaps.vGap16,
            Gaps.vGap8,
            Container(
              // 隐藏点击效果
              color: ThemeUtils.getBackgroundColor(context),
              child: TabBar(
                onTap: (index){
                  if (!mounted){
                    return;
                  }
                  _pageController.jumpToPage(index);
                },
                isScrollable: true,
                controller: _tabController,
                labelStyle: TextStyles.textBold18,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.only(left: 16.0),
                unselectedLabelColor: ThemeUtils.isDark(context) ? Colours.text_gray : Colours.text,
                labelColor: Theme.of(context).primaryColor,
                indicatorPadding: const EdgeInsets.only(left: 12.0, right: 36.0),
                tabs: <Widget>[
                  const _TabView("在售", 0),
                  const _TabView("待售", 1),
                  const _TabView("下架", 2),
                ],
              ),
            ),
            Gaps.line,
            Expanded(
              child: PageView.builder(
                key: const Key('pageView'),
                itemCount: 3,
                onPageChanged: _onPageChange,
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  return GoodsList(index: index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _onPageChange(int index) {
    _tabController.animateTo(index);
    provider.setIndex(index);
  }

  /// design/4商品/index.html#artboard3
  _showSortMenu(){
    // 获取点击控件的坐标
    final RenderBox button = _buttonKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    // 获得控件左下方的坐标
    var a =  button.localToGlobal(Offset(0.0, button.size.height + 12.0), ancestor: overlay);
    // 获得控件右下方的坐标
    var b =  button.localToGlobal(button.size.bottomLeft(Offset(0, 12.0)), ancestor: overlay);
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a, b),
      Offset.zero & overlay.size,
    );
    final RenderBox body = _bodyKey.currentContext.findRenderObject();

    TextStyle textStyle = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Theme.of(context).primaryColor,
    );
    showPopupWindow(
      context: context,
      fullWidth: true,
      position: position,
      elevation: 0.0,
      child: GestureDetector(
        onTap: () => NavigatorUtils.goBack(context),
        child: Container(
          color: const Color(0x99000000),
          height: body.size.height - button.size.height - 12.0,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: _sortList.length + 1,
            itemBuilder: (_, index){
              Color backgroundColor = ThemeUtils.getBackgroundColor(context);
              return index == _sortList.length ? Container(
                color: backgroundColor,
                height: 12.0,
              ) : Material(
                color: backgroundColor,
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _sortList[index],
                          style: index == _sortIndex ? textStyle : null,
                        ),
                        Text(
                          "($index)",
                          style: index == _sortIndex ? textStyle : null,
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      _sortIndex = index;
                    });
                    Toast.show("选择分类: ${_sortList[index]}");
                    NavigatorUtils.goBack(context);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// design/4商品/index.html#artboard4
  _showAddMenu(){
    final RenderBox button = _addKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    var a =  button.localToGlobal(Offset(button.size.width - 8.0, button.size.height - 12.0), ancestor: overlay);
    var b =  button.localToGlobal(button.size.bottomLeft(Offset(0, - 12.0)), ancestor: overlay);
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a, b),
      Offset.zero & overlay.size,
    );
    final Color backgroundColor = ThemeUtils.getBackgroundColor(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    showPopupWindow(
      context: context,
      fullWidth: false,
      isShowBg: true,
      position: position,
      elevation: 0.0,
      child: GestureDetector(
        onTap: () => NavigatorUtils.goBack(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: LoadAssetImage("goods/jt", width: 8.0, height: 4.0,
                color: ThemeUtils.getDarkColor(context, Colours.dark_bg_color),
              ),
            ),
            SizedBox(
              width: 120.0,
              height: 40.0,
              child: FlatButton.icon(
                textColor: Theme.of(context).textTheme.body1.color,
                onPressed: (){
                  NavigatorUtils.push(context, '${GoodsRouter.goodsEditPage}?isAdd=true&isScan=true', replace: true);
                },
                color: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                ),  
                icon: LoadAssetImage("goods/scanning", width: 16.0, height: 16.0, color: _iconColor,),
                label: const Text("扫码添加")
              ),
            ),
            Container(width: 120.0, height: 0.6, color: Colours.line),
            SizedBox(
              width: 120.0,
              height: 40.0,
              child: FlatButton.icon(
                textColor: Theme.of(context).textTheme.body1.color,
                color: backgroundColor,
                onPressed: (){
                  NavigatorUtils.push(context, '${GoodsRouter.goodsEditPage}?isAdd=true', replace: true);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                ),
                icon: LoadAssetImage("goods/add2", width: 16.0, height: 16.0, color: _iconColor,),
                label: const Text("添加商品")
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _TabView extends StatelessWidget {
  
  const _TabView(this.tabName, this.index);
  
  final String tabName;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    return Consumer<GoodsPageProvider>(
      builder: (_, provider, child){
        return  Tab(
            child: SizedBox(
              width: 78.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(tabName),
                  Offstage(offstage: provider.goodsCountList[index] == 0 || provider.index != index, child: Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(" (${provider.goodsCountList[index]}件)", style: TextStyle(fontSize: Dimens.font_sp12)),
                  )),
                ],
              ),
            )
        );
      },
    );
  }
}
