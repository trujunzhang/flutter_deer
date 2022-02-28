import 'package:flutter/material.dart';
import 'package:flutter_deer_djzhang/res/constant.dart';
import 'package:flutter_deer_djzhang/home/home_page.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_deer_djzhang/main.dart';

/// 运行 flutter drive --target=test_driver/order/order.dart
void main() {
  enableFlutterDriverExtension();
  Constant.isDriverTest = true;
  runApp(MyApp(home: const Home()));
}
