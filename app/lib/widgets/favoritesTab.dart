import 'package:flutter/material.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavoritesTab createState() => _FavoritesTab();
}

class _FavoritesTab extends State<FavoritesTab> {
  bool isSearching = false;

  void doSearch(searchItem) {
    if (searchItem.length > 4) {
      //TODO search for the users favorite questions given by the search item
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //change to a text field when the searched icon is clicked
        title: !isSearching
            ? Center(child: Text("Favorites"))
            : TextField(
                onChanged: (value) {
                  print(value);
                },
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Search here......",
                ),
              ),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel_outlined),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search_rounded),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
        ],
      ),

      //TODO populate the screen with users favorite questions
      //if the are no favorites questions display the center object below
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 64,
            ),
            Text(
              'no favorites to show',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
