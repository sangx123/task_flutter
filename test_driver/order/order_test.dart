import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../tools/test_utils.dart';

void main() {

  group('订单部分：', (){
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });

    tearDown((){
      print('< Success');
    });

    tearDownAll(() async {
      driver?.close();
    });
    
    test("滑动订单列表",() async {
      await driver.tap(find.byValueKey('订单'));
      
      // 水平滑动
      final pageView = find.byValueKey('pageView');
      await driver.scroll(pageView, -400.0, 0, scrollDuration);
      await delayed();
      await driver.scroll(pageView, -400.0, 0, scrollDuration);
      await delayed();
      final orderList = find.byValueKey('order_list');
      await driver.waitFor(orderList);
      final orderItem = find.byValueKey('order_item_7');
      await delayed();
      // 垂直滑动
      await driver.scrollUntilVisible(orderList, orderItem, dyScroll: -400);
      await delayed();

    });

    test("订单操作",() async {
      // 点击订单列表按钮
      await driver.tap(find.byValueKey('order_button_1_1'));
      await delayed();
      await driver.tap(find.text('取消'));
      await delayed();
      await driver.tap(find.byValueKey('order_button_3_1'));
      await delayed();
      await driver.tap(find.text('确定'));
      await driver.scroll(find.byValueKey('order_list'), 0.0, 500.0, scrollDuration);
    });

    test("订单详情页",() async {
      final orderItem = find.byValueKey('order_item_2');
      await driver.tap(orderItem);
      await driver.tap(find.text('订单跟踪'));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.scroll(find.byValueKey('order_info'), 0.0, -1000.0, scrollDuration);
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
    });

    test("订单搜索页测试",() async {
      await driver.tap(find.byTooltip('搜索'));
      await driver.tap(find.byValueKey('srarch_text_field'));
      await driver.enterText('flutter');
      await driver.tap(find.text('搜索'));
      final orderList = find.byValueKey('order_search_list');
      await driver.waitFor(orderList);
      await driver.scroll(orderList, 0.0, -300.0, scrollDuration);
      await delayed();
      await driver.tap(find.byValueKey('search_back'));
      await delayed();
    });
  });
}