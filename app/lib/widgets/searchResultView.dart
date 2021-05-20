//@dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;
  final int tab;
  final List<Icon> myTab = [
    Icon(
      Icons.home,
      size: 64,
    ),
    Icon(
      Icons.favorite,
      size: 64,
    ),
    Icon(
      Icons.notifications_active,
      size: 64,
    )
  ];

  SearchResultsListView(
      {Key key, @required this.searchTerm, @required this.tab})
      : super(key: key);

//the following method in for showing a toast

  void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: 'UNDO', onPressed: () {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (searchTerm.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.home,
              size: 64,
            ),
            Text(
              'Home',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      );
    }

    final size = FloatingSearchBar.of(context);

    return ListView(
        padding: EdgeInsets.only(top: size.height + size.margins.vertical),
        children: List.generate(
            13,
            (index) => ListTile(
                  title: Text('$searchTerm has been found'),
                  subtitle: Text(''),
                  //Add a navigator in the onTab method for when a question is clicked
                  onTap: () => showToast(context, "showing detailed question"),
                )));
  }
}
