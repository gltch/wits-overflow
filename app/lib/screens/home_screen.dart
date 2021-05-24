import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wits_overflow/widgets/floatingSearchBar.dart';
import 'package:wits_overflow/widgets/favoritesTab.dart';
import 'package:wits_overflow/widgets/postedQuestionsTab.dart';
import 'package:wits_overflow/utils/sidebar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  final _view = [
    Container(child: MySearchBar(myTab: 0)),
    FavoritesTab(),
    PostedQuestionsTab()
  ];

  @override
  Widget build(BuildContext context) {
    Scaffold view = Scaffold(
      drawer: SideDrawer(),
      body: _view[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_awesome), label: 'Favorites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.post_add_outlined), label: 'Posted')
          ],
          onTap: (index) {
            setState(() {
              _currentTab = index;
            });
          }),
    );

    return view;
  }
}
