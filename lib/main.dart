import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:provider/provider.dart';

import 'cartProvider.dart';

import 'menu.dart';
import 'cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Restaurant Ordering App',
        home: MainScaffold(),
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    MenuPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(
              Icons.menu_book,
              color: Colors.grey.shade800,
            ),
            title: Text("Menu"),
            selectedColor: Colors.grey.shade500,
          ),
          SalomonBottomBarItem(
            icon: Icon(
              Icons.list,
              color: Colors.grey.shade800,
            ),
            title: Text("Orders"),
            selectedColor: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }
}
