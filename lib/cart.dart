import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cartProvider.dart';

import 'elements.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    // Create a list of CartItemWidgets from the cart items
    List<Widget> cartItemList =
        cart.items.values.map((item) => CartItemWidget(item: item)).toList();

    // Calculate the total price for the cart
    double subtotal = cart.totalAmount; // Sum of product prices times quantity
    double delivery = 5.0; // Assuming a flat delivery fee for demonstration
    double total = subtotal + delivery;

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: cartItemList,
          ),
        ),
        CartTotalWidget(
          subtotal: subtotal,
          delivery: delivery,
          total: total,
        ),
      ],
    );
  }
}

class CartTotalWidget extends StatelessWidget {
  final double subtotal;
  final double delivery;
  final double total;

  CartTotalWidget({
    Key? key,
    required this.subtotal,
    required this.delivery,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Bestellung', style: TextStyle(color: Colors.grey[600])),
              Text('€${subtotal.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.black)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Lieferkosten', style: TextStyle(color: Colors.grey[600])),
              Text('€${delivery.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.black)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Zusammenfassung',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('€${total.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 16),
          PressableButton(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 120),
            onPressed: () {
              // Handle order food action
            },
            child: Text('ORDER FOOD'),
          ),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  CartItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey[300]!, Colors.grey[200]!],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(item.image),
            radius: 30,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '€${item.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Anzahl: ${item.quantity}',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
