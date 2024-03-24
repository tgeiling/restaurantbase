import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartProvider.dart';

final List<Map<String, dynamic>> _foodItems = [
  {
    "title": "Food 1",
    "image": "assets/menu/food1.jpg",
    "description": "Delicious food item 1."
  },
  {
    "title": "Food 2",
    "image": "assets/menu/food2.jpg",
    "description": "Tasty and healthy food item 2."
  },
  {
    "title": "Food 3",
    "image": "assets/menu/food3.jpg",
    "description": "Tasty and healthy food item 2."
  },
  {
    "title": "Food 4",
    "image": "assets/menu/food4.jpg",
    "description": "Tasty and healthy food item 2."
  },
  {
    "title": "Food 5",
    "image": "assets/menu/food5.jpg",
    "description": "Tasty and healthy food item 2."
  },
  {
    "title": "Food 6",
    "image": "assets/menu/food6.jpg",
    "description": "Tasty and healthy food item 2."
  },
];

final List<Map<String, dynamic>> _drinkItems = [
  {
    "title": "Coffee",
    "image": "assets/menu/coffee.jpg",
    "description": "Freshly brewed coffee."
  },
  {
    "title": "Wine",
    "image": "assets/menu/wine.jpg",
    "description": "Fine red wine."
  },
];

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with AutomaticKeepAliveClientMixin<MenuPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          Text('Food',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _foodItems.length,
            itemBuilder: (context, index) =>
                MenuItemWidget(item: _foodItems[index]),
          ),
          SizedBox(
            height: 100,
          ),
          Text('Drinks',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _drinkItems.length,
            itemBuilder: (context, index) =>
                MenuItemWidget(item: _drinkItems[index]),
          ),
        ],
      ),
    );
  }
}

class MenuItemWidget extends StatefulWidget {
  final Map<String, dynamic> item;

  MenuItemWidget({required this.item});

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
    int quantity = cart.getSelectedQuantity(widget.item["title"]);

    return Column(
      children: [
        InkWell(
          onTap: toggleExpand,
          child: Card(
            elevation: 4.0,
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: <Widget>[
                Hero(
                  tag: widget.item["title"]!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    child: Image.asset(
                      widget.item["image"]!,
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
                          widget.item["title"]!,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          widget.item["description"]!,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: quantity > 0
                    ? () {
                        cart.decrementSelectedQuantity(widget.item["title"]);
                      }
                    : null,
              ),
              Text('$quantity'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  cart.incrementSelectedQuantity(widget.item["title"]);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
