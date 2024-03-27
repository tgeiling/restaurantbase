import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartProvider.dart';

final List<CartItem> foodItems = [
  CartItem(
    id: "food1",
    title: "Food 1",
    image: "assets/menu/food1.jpg",
    description: "Delicious food item 1.",
    price: 20.0,
  ),
  CartItem(
    id: "food2",
    title: "Food 2",
    image: "assets/menu/food2.jpg",
    description: "Tasty and healthy food item 2.",
    price: 15.0,
  ),
  CartItem(
    id: "food3",
    title: "Food 3",
    image: "assets/menu/food3.jpg",
    description: "Tasty and healthy food item 3.",
    price: 15.0,
  ),
  CartItem(
    id: "food4",
    title: "Food 4",
    image: "assets/menu/food4.jpg",
    description: "Tasty and healthy food item 4.",
    price: 15.0,
  ),
  CartItem(
    id: "food5",
    title: "Food 5",
    image: "assets/menu/food5.jpg",
    description: "Tasty and healthy food item 5.",
    price: 15.0,
  ),
  CartItem(
    id: "food6",
    title: "Food 6",
    image: "assets/menu/food6.jpg",
    description: "Tasty and healthy food item 6.",
    price: 15.0,
  ),
];

final List<CartItem> drinkItems = [
  CartItem(
    id: "drink1",
    title: "Coffee",
    image: "assets/menu/coffee.jpg",
    description: "Freshly brewed coffee.",
    price: 5.0,
  ),
  CartItem(
    id: "drink2",
    title: "Wine",
    image: "assets/menu/wine.jpg",
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text('Food',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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

    return Column(
      children: [
        InkWell(
          onTap: toggleExpand,
          child: Card(
            elevation: 4.0,
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: <Widget>[
                Hero(
                  tag: widget.item.id, // Use item's id for Hero tag
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    child: Image.asset(
                      widget.item.image, // Use item's image property
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.item.title, // Use item's title property
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          widget.item
                              .description, // Use item's description property
                          style: TextStyle(fontSize: 14.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isExpanded ? 50.0 : 0,
          child: isExpanded
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        cart.decrementOrRemoveItem(
                            widget.item.id); // Adjust to use item's id
                      },
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        cart.addOrIncrementItem(
                            widget.item.id,
                            widget.item.title,
                            widget.item.image,
                            widget.item.description,
                            widget.item
                                .price); // Adjust to match the new method signature
                      },
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
