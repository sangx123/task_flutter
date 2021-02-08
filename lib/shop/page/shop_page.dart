
import 'package:flutter/material.dart';
import 'package:flutter_deer/account/account_router.dart';
import 'package:flutter_deer/mvp/base_page_state.dart';
import 'package:flutter_deer/order/order_router.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/setting/setting_router.dart';
import 'package:flutter_deer/shop/models/user_entity.dart';
import 'package:flutter_deer/shop/presenter/shop_presenter.dart';
import 'package:flutter_deer/shop/provider/user_provider.dart';
import 'package:flutter_deer/shop/shop_router.dart';
import 'package:flutter_deer/store/store_router.dart';
import 'package:flutter_deer/task/test/test_forcus.dart';
import 'package:flutter_deer/task/task_router.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/click_item.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:provider/provider.dart';

/// design/6店铺-账户/index.html#artboard0
class ShopPage extends StatefulWidget {
  @override
  ShopPageState createState() => ShopPageState();
}

class ShopPageState extends BasePageState<ShopPage, ShopPagePresenter> with AutomaticKeepAliveClientMixin<ShopPage>{
  
  var menuTitle = ["账户流水", "资金管理", "提现账号"];
  var menuImage = ["zhls", "zjgl", "txzh"];
  var menuDarkImage = ["dark_zhls", "dark_zjgl", "dark_txzh"];
  var menuImageTask=["dps_s","xdd_n"];
  var menuImageTaskTitle=["我发布的任务", "我接收到的任务"];
  UserProvider provider = UserProvider();
  
  void setUser(UserEntity user){
    provider.setUser(user);
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    return ChangeNotifierProvider<UserProvider>(
      create: (_) => provider,
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                onPressed: (){
                  NavigatorUtils.push(context, ShopRouter.messagePage);
                },
                icon: LoadAssetImage(
                  "shop/message",
                  key: const Key('message'),
                  width: 24.0,
                  height: 24.0,
                  color: _iconColor,
                ),
              ),
              IconButton(
                onPressed: (){
                  NavigatorUtils.push(context, SettingRouter.settingPage);
                },
                icon: LoadAssetImage(
                  "shop/setting",
                  key: const Key('setting'),
                  width: 24.0,
                  height: 24.0,
                  color: _iconColor,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Gaps.vGap12,
                Consumer<UserProvider>(
                  builder: (_, provider, __) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child:
                      InkWell(
                        //onTap:()=> NavigatorUtils.push(context, StoreRouter.auditPage),
                          onTap:()=> NavigatorUtils.push(context, SettingRouter.accountManagerPage),

                      child:
                          Row(children: [
                            CircleAvatar(
                                  radius: 28.0,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: ImageUtils.getImageProvider((provider.user==null||provider.user.avatar==null)?"":provider.user.avatar, holderImg: 'shop/tx')
                              ),
                          Gaps.hGap16,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                //Provider.of<UserProvider>(context).user.name,
                                provider.user!=null?provider.user.name : "",
                                style: TextStyles.textBold18,
                                textAlign:TextAlign.left,
                              ),
                              Gaps.vGap10,
                              Text(
                                //Provider.of<UserProvider>(context).user.name,
                                provider.user!=null?provider.user.mobile : ""
                              ),
                            ],
                          )

                          ],)
//                      Stack(
//                        children: <Widget>[
//                          const SizedBox(width: double.infinity, height: 56.0),
//                          Text(
//                            //Provider.of<UserProvider>(context).user.name,
//                            provider.user!=null?provider.user.name : "",
//                            style: TextStyles.textBold24,
//                          ),
//                          Positioned(
//                              left: 0.0,
//                              child: CircleAvatar(
//                                  radius: 28.0,
//                                  backgroundColor: Colors.transparent,
//                                  backgroundImage: ImageUtils.getImageProvider("https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2415100391,2445796972&fm=26&gp=0.jpg", holderImg: 'shop/tx')
//                              )
//                          ),
////                        Positioned(
////                          top: 38.0,
////                          left: 0.0,
////                          child: Row(
////                            children: <Widget>[
////                              const LoadAssetImage("shop/zybq", width: 40.0, height: 16.0,),
////                              Gaps.hGap8,
////                              const Text("店铺账号:15000000000", style: TextStyles.textSize12)
////                            ],
////                          ),
////
////                        ),
//                        ],
//                      ),
                      ),
                    );
                  },
                ),
                Gaps.vGap12,
                Gaps.vGap12,
                Container(height: 10, width: double.infinity, child: Gaps.line10,),
//              Gaps.vGap12,
//              const Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                child: const Text(
//                  "账户",
//                  style: TextStyles.textBold18,
//                ),
//              ),
//              Gaps.vGap12,
//              Container(height: 0.6, width: double.infinity, child: Gaps.line),
                ClickItem(
                    title: "账单",
                    onTap: () => NavigatorUtils.push(context, AccountRouter.accountRecordListPage)
                ),
                ClickItem(
                    title: "余额",
                    onTap: () => NavigatorUtils.push(context, AccountRouter.accountPage)
                ),
                ClickItem(
                    title: "银行卡",
                    onTap: () => NavigatorUtils.push(context, AccountRouter.withdrawalAccountPage)
                ),
//              Flexible(
//                child: GridView.builder(
//                  shrinkWrap: true,
//                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
//                  physics: NeverScrollableScrollPhysics(),
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisCount: 4,
//                    childAspectRatio: 1.18
//                  ),
//                  itemCount: menuTitle.length,
//                  itemBuilder: (_, index){
//                    return InkWell(
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          LoadAssetImage(ThemeUtils.isDark(context) ? "shop/${menuDarkImage[index]}" : "shop/${menuImage[index]}", width: 32.0),
//                          Gaps.vGap4,
//                          Text(
//                            menuTitle[index],
//                            style: TextStyles.textSize12,
//                          )
//                        ],
//                      ),
//                      onTap: (){
//                        if (index == 0){
//                          NavigatorUtils.push(context, AccountRouter.accountRecordListPage);
//                        }else if (index == 1){
//                          NavigatorUtils.push(context, AccountRouter.accountPage);
//                        }else if (index == 2){
//                          NavigatorUtils.push(context, AccountRouter.withdrawalAccountPage);
//                        }
//                      },
//                    );
//                  },
//                ),
//              ),

                Container(height: 10, width: double.infinity, child: Gaps.line10,),
//              Gaps.vGap12,
//              const Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                child: const Text(
//                  "任务",
//                  style: TextStyles.textBold18,
//                ),
//              ),
//              Gaps.vGap12,
//              Container(height: 0.6, width: double.infinity, child: Gaps.line),
                ClickItem(
                    title: "我发布的任务",
                    //onTap: () =>  NavigatorUtils.goWebViewPage(context, "我的任务", "http://192.168.0.127:8081/#/pages/index/index")
                    onTap: () =>  NavigatorUtils.push(context,ShopRouter.myFabuTaskManagerHome)

                    //onTap: () =>  NavigatorUtils.goWebViewPage(context, "我的任务", "https://static-e6fd6f31-d6a7-422f-8a80-a0ac3bc56ad4.bspapp.com/#/pages/template/template")
                ),
                ClickItem(
                    title: "我领取的任务",
                    onTap: () =>  NavigatorUtils.push(context,ShopRouter.myJieshouTaskManagerHome)
                ),
                ClickItem(
                    title: "意见反馈",
                    onTap: () => NavigatorUtils.push(context, ShopRouter.feedbackPage)
                ),

//                Flexible(
//                  flex: 1,
//                  child: Container(
//                    color: Colors.blue,
//                  ),
//                )
                Container(height: 10, width: double.infinity, child: Gaps.line10,),
//              Flexible(
//                child: GridView.builder(
//                  shrinkWrap: true,
//                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
//                  physics: NeverScrollableScrollPhysics(),
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 4,
//                      childAspectRatio: 1.18
//                  ),
//                  itemCount: menuImageTaskTitle.length,
//                  itemBuilder: (_, index){
//                    return InkWell(
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          LoadAssetImage(ThemeUtils.isDark(context) ? "order/${menuImageTask[index]}" : "order/${menuImageTask[index]}", width: 32.0),
//                          Gaps.vGap4,
//                          Text(
//                            menuImageTaskTitle[index],
//                            style: TextStyles.textSize12,
//                          )
//                        ],
//                      ),
//                      //onTap: () => NavigatorUtils.push(context, ShopRouter.shopSettingPage),
//                      onTap: () {
//                        if (index == 0){
//                          NavigatorUtils.push(context, AccountRouter.accountRecordListPage);
//                        }else if (index == 1){
//                          NavigatorUtils.push(context, AccountRouter.accountPage);
//                         }
//                      },
//                    );
//                  },
//                ),
//              ),
              ],
            ),

          )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  ShopPagePresenter createPresenter() {
    return ShopPagePresenter();
  }
}
