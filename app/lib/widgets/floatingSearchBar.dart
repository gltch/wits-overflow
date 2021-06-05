import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:wits_overflow/widgets/searchResultView.dart';

class MySearchBar extends StatefulWidget {
  @override
  _MySearchBar createState() => _MySearchBar();
}

class _MySearchBar extends State<MySearchBar> {
  static const int historySize = 5;

  List<String> history = [
    'Coms1015A',
    'IDSA',
    'Mechanics',
    'Optimisation',
    'Mobile computing'
  ];

  List<String> filteredHistory = [];

  String selectedItem = '';

  List<String> filterItem({
    required String filter,
  }) {
    if (filter.isNotEmpty) {
      return history.reversed.where((term) => term.startsWith(filter)).toList();
    } else {
      return history.reversed.toList();
    }
  }

  void addSearchItem(String item) {
    if (history.contains(item)) {
      putSearchTermFirst(item);
      return;
    }

    history.add(item);

    if (history.length > historySize) {
      history.removeRange(0, history.length - historySize);
    }

    filteredHistory = filterItem(filter: '');
  }

  void putSearchTermFirst(String item) {
    deleteSearchItem(item);
    addSearchItem(item);
  }

  void deleteSearchItem(String item) {
    history.removeWhere((term) => term == item);
    filteredHistory = filterItem(filter: '');
  }

  FloatingSearchBarController controller = FloatingSearchBarController();

  @override
  void initState() {
    super.initState();
    filteredHistory = filterItem(filter: '');
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      controller: controller,
      key: Key("Search here"),
      //TODO replace the body so that when we navigate to different tabs we get populate with relevent results
      body: FloatingSearchBarScrollNotifier(
        child: SearchResultsListView(
          searchTerm: history.isNotEmpty ? history.reversed.first : '',
        ),
      ),
      transition: CircularFloatingSearchBarTransition(),
      physics: BouncingScrollPhysics(),
      hint: "Search here......",
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      onQueryChanged: (query) {
        setState(() {
          filteredHistory = filterItem(filter: query);
        });
      },
      onSubmitted: (query) {
        setState(() {
          addSearchItem(query);
          selectedItem = query;
          print("hey we are in here");
        });
        controller.close();
      },
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Material(
            color: Colors.white,
            elevation: 4,
            child: Builder(builder: (context) {
              if (filteredHistory.isEmpty && controller.query.isEmpty) {
                return Container(
                  height: 56,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Search history....',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              } else if (filteredHistory.isEmpty) {
                return ListTile(
                  key: Key('Search item'),
                  title: Text(controller.query),
                  leading: const Icon(Icons.search),
                  onTap: () {
                    setState(() {
                      addSearchItem(controller.query);
                      selectedItem = controller.query;
                    });
                    controller.close();
                  },
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: filteredHistory
                      .map((term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  deleteSearchItem(term);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                putSearchTermFirst(term);
                                selectedItem = term;
                              });
                              controller.close();
                            },
                          ))
                      .toList(),
                );
              }
            }),
          ),
        );
      },
    );
  }
}
