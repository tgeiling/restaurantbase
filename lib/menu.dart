import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartProvider.dart';

final List<CartItem> foodItems = [
  CartItem(
    id: "food1",
    title: "Schinken Toast",
    image: "assets/menu/food1.png",
    description: "Dinkeltoast, Cheddar, Kochschinken",
    price: 20.0,
  ),
  CartItem(
    id: "food2",
    title: "Zanderfilet",
    image: "assets/menu/food2.png",
    description: "Zanderfilet, Möhren, Rosenkohl",
    price: 15.0,
  ),
  CartItem(
    id: "food3",
    title: "Reis Bowl",
    image: "assets/menu/food6.png",
    description:
        "Vollkornreis, Gurke, Sprossen, Chilli Paste, Frische Chillis, Baby Mais, Zwiebeln",
    price: 15.0,
  ),
  CartItem(
    id: "food4",
    title: "Food 4",
    image: "assets/menu/food4.png",
    description: "Tasty and healthy food item 4.",
    price: 15.0,
  ),
  CartItem(
    id: "food5",
    title: "Food 5",
    image: "assets/menu/food5.png",
    description: "Tasty and healthy food item 5.",
    price: 15.0,
  ),
  CartItem(
    id: "food6",
    title: "Food 6",
    image: "assets/menu/food3.png",
    description: "Tasty and healthy food item 6.",
    price: 15.0,
  ),
];

final List<CartItem> drinkItems = [
  CartItem(
    id: "drink1",
    title: "Coffee",
    image: "assets/menu/drink1.png",
    description: "Freshly brewed coffee.",
    price: 5.0,
  ),
  CartItem(
    id: "drink2",
    title: "Wine",
    image: "assets/menu/drink2.png",
    description: "Fine red wine.",
    price: 30.0,
  ),
];

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with AutomaticKeepAliveClientMixin<MenuPage> {
  @override
  bool get wantKeepAlive => true;

  List<Widget> buildMenuItems(List<CartItem> items) {
    return items
        .map((item) => MenuItemWidget(key: ValueKey(item.id), item: item))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final foodWidgets = buildMenuItems(
        foodItems); // Assuming foodItems is already a List<CartItem>
    final drinkWidgets = buildMenuItems(
        drinkItems); // Assuming drinkItems is converted to List<CartItem>

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Image.asset('assets/logo.png', height: 100),
            ),
          ),
          ...foodWidgets,
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text('Drinks',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          ...drinkWidgets,
          SizedBox(height: 100), // Optional extra space at the bottom
        ],
      ),
    );
  }
}

class MenuItemWidget extends StatefulWidget {
  final CartItem item;

  MenuItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  bool isExpanded = false;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    int quantity = cart.getSelectedQuantity(widget.item.id);

    return Stack(children: [
      Card(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: toggleExpand,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      left: 140,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.grey[350]!,
                          Colors.grey[200]!,
                        ], // Adjust these colors to match your design for the gradient effect
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.title,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          widget.item.description,
                          style: TextStyle(fontSize: 12.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '€${widget.item.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isExpanded) // Add this line
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.red),
                        onPressed: quantity > 0
                            ? () {
                                cart.decrementOrRemoveItem(widget.item.id);
                              }
                            : null,
                      ),
                      Text('$quantity', style: TextStyle(fontSize: 18.0)),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () {
                          cart.addOrIncrementItem(
                            widget.item.id,
                            widget.item.title,
                            widget.item.image,
                            widget.item.description,
                            widget.item.price,
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 0, // Negative value to have it overflow from the top of the card
        left:
            -16, // Adjust this value as needed to align it with the card's left edge
        child: Hero(
          tag: widget.item.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              widget.item.image,
              height: 160.0, // Adjust height as necessary
              width: 160.0, // Adjust width as necessary
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ]);
  }
}
