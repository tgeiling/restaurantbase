import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cartProvider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (context, index) {
              String key = cart.items.keys.elementAt(index);
              CartItem item = cart.items[key]!;
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/menu/${item.id}.jpg'),
                ),
                title: Text(item.title),
                subtitle: Text('Quantity: ${item.quantity}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    cart.removeItemCompletely(key);
                  },
                ),
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}', // Assuming no taxes or additional fees for simplicity
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
