import 'package:flutter_deer_djzhang/mvp/mvps.dart';
import 'package:flutter_deer_djzhang/order/models/search_entity.dart';
import 'package:flutter_deer_djzhang/order/provider/base_list_provider.dart';

abstract class OrderSearchIMvpView implements IMvpView {
  BaseListProvider<SearchItems> get provider;
}
