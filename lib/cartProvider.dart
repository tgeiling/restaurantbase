import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final String image;
  final String description;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    this.quantity = 1,
    required this.price,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    return _items.values
        .fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  void addOrIncrementItem(String productId, String title, String image,
      String description, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          image: existingCartItem.image,
          description: existingCartItem.description,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          image: image,
          description: description,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void decrementOrRemoveItem(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > 1) {
        _items.update(
          productId,
          (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            image: existingCartItem.image,
            description: existingCartItem.description,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1,
          ),
        );
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  int getSelectedQuantity(String productId) {
    if (_items.containsKey(productId)) {
      return _items[productId]!.quantity;
    }
    return 0;
  }

  void removeItemCompletely(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
