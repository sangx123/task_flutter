import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/provider/theme_provider.dart';
import 'package:flutter_deer/routers/application.dart';
import 'package:flutter_deer/routers/routers.dart';
import 'package:flutter_deer/task/page/task_detail.dart';
import 'package:flutter_deer/task/test/Widget_RefreshIndicator_State.dart';
import 'package:flutter_deer/task/page/task_pay.dart';
import 'package:flutter_deer/task/test/issuse_message_page.dart';
import 'package:flutter_deer/util/log_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:oktoast/oktoast.dart';
import 'package:flutter_deer/home/splash_page.dart';
import 'package:provider/provider.dart';

import 'task/test/ListBodyDemo.dart';
import 'task/test/ScrollToIndexDemoPage2.dart';
import 'task/page/task_publish.dart';

void main() {
//  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
//  debugRepaintRainbowEnabled = true;
  runApp(MyApp());
  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  
  final Widget home;
  
  MyApp({this.home}) {
    Log.init();
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  
  @override
  Widget build(BuildContext context) {

    return OKToast(
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (_, provider, __) {
            return MaterialApp (
              title: 'Flutter Deer',
              //showPerformanceOverlay: true, //显示性能标签
              //debugShowCheckedModeBanner: false,
              //checkerboardRasterCacheImages: true,
              theme: provider.getTheme(),
              darkTheme: provider.getTheme(isDarkMode: true),
              //home: home ?? SplashPage(),
              home: getHomePage(),
              onGenerateRoute: Application.router.generator,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('zh', 'CH'),
                Locale('en', 'US')
              ]
            );
          },
        ),
      ),
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom
    );
  }

  Widget getHomePage(){
    //return PublishTaskPage();
    //return ScrollToIndexDemoPage2();
    return SplashPage();

    //return TaskDetailPage();
    //return TaskPayPage();
    //return Widget_RefreshIndicator_Page();
  }
}
