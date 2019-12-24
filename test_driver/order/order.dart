import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/home/home_page.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_deer/main.dart';

/// 运行 flutter drive --target=test_driver/order/order.dart
void main() {
  enableFlutterDriverExtension();
  Constant.isTest = true;
  runApp(MyApp(home: Home()));
}