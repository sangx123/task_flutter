//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//
//main() {
//  //全局的Provider，此处传递一个对象进去
//  runApp(ChangeNotifierProvider<Counter>.value(
//    child: MyApp(),
//  ));
//}
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MaterialApp(
//      title: "Provider",
//      home: HomePage(),
//    );
//  }
//}
//
//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Home"),
//        actions: <Widget>[
//          FlatButton(
//            child: Text("下一页"),
//            onPressed: () =>
//                Navigator.push(context, MaterialPageRoute(builder: (context) {
//                  return SecondPage();
//                })),
//          ),
//        ],
//      ),
//      body: Center(
//        child: Text("${Provider.of<Counter>(context).count}"),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          Provider.of<Counter>(context).add();
//        },
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}
//
//class SecondPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("第二页"),
//      ),
//      body: Center(
//        child: Text("${Provider.of<Counter>(context).count}"),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          //Provider.of<Counter>(context)获取共享的Counter对象
//          Provider.of<Counter>(context).add();
//        },
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}
////定义共享的对象
//class Counter with ChangeNotifier {
//
//  int _count;
//
//  Counter(this._count);
//
//  void add() {
//    _count++;
//    //通知用到Counter对象的widget刷新用的
//    notifyListeners();
//  }
//
//  get count => _count;
//}