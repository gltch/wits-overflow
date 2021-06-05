import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  SearchResultsListView({Key? key, required this.searchTerm}) : super(key: key);

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

    return ListView(
        padding: EdgeInsets.only(top: 95, bottom: 56),
        children: List.generate(
            13,
            (index) => ListTile(
                  key: Key("list of questions"),
                  title: Text('$searchTerm has been found'),
                  subtitle: Text('Body will go here.....'),
                  //Add a navigator in the onTab method for when a question is clicked
                  onTap: () => showToast(context, "showing detailed question"),
                )));
  }
}
