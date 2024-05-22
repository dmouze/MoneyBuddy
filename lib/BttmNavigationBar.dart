import 'package:flutter/material.dart';

class BttmNavigationBar extends StatefulWidget {
  final List<BttmNavigationBarModel> items;
  final List<Widget> screens;

  BttmNavigationBar({
    required this.items,
    required this.screens,
  });

  @override
  _BttmNavigationBarState createState() => _BttmNavigationBarState();
}

class _BttmNavigationBarState extends State<BttmNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe2e5e7),
      bottomNavigationBar: BottomNavigationBar(
        items: widget.items.map((BttmNavigationBarModel item) {
          return BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.label,
          );
        }).toList(),
        backgroundColor: Color(0xffffffff),
        currentIndex: _selectedIndex,
        elevation: 8,
        iconSize: 24,
        selectedItemColor: Color(0xff49c4ad),
        unselectedItemColor: Color(0xff9e9e9e),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
      body: widget.screens[_selectedIndex],
    );
  }
}

class BttmNavigationBarModel {
  final IconData icon;
  final String label;

  BttmNavigationBarModel({
    required this.icon,
    required this.label,
  });
}
