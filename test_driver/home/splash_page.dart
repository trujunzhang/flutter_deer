import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_deer_djzhang/main.dart' as app;

/// 运行 flutter drive --target=test_driver/home/splash_page.dart
void main() {
  enableFlutterDriverExtension();
  app.main();
}
