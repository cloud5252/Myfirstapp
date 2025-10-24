import 'package:stacked/stacked.dart';

class FavoriteViewModel extends BaseViewModel {}

class CartItem11 {
  final String name;
  final int quantity;

  CartItem11({required this.name, this.quantity = 0});
}

enum FoodCategory {
  burgers,
  salads,
  sides,
  desserts,
  drinks,
}
