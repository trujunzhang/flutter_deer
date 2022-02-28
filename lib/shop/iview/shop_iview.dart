import 'package:flutter_deer_djzhang/mvp/mvps.dart';
import 'package:flutter_deer_djzhang/shop/models/user_entity.dart';

abstract class ShopIMvpView implements IMvpView {
  void setUser(UserEntity? user);

  bool get isAccessibilityTest;
}
