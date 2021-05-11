import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:wits_overflow/widgets/customNavBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
/*  Future questionsFeed() async {
    var feed = await http
        .get(Uri.http("wits-overflow-pre-api.herokuapp.com", "/questions"));
    var jsonData = jsonDecode(feed.body);

    List<QuestionFeed> questions = [];

    for (var question in jsonData) {
      QuestionFeed questionsFeed =
          QuestionFeed(question['title'], question['score']);

      questions.add(questionsFeed);
    }

    print("This is working");
    return questions;


    body: Container(
        width: 100,
        child: TextField(
          controller: getFilters,
          decoration: InputDecoration(
            hintText: 'Filter by ',
            border: OutlineInputBorder(),
          ),
        ),
      ),
  }*/

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
    @required String filter = '',
  }) {
    if (filter != null && filter.isNotEmpty) {
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
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Scaffold view = Scaffold(
      drawer: customNavBar(),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: SearchResultsListView(
            searchTerm: selectedItem,
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
      ),
    );

    return view;
  }
}

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (searchTerm.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Search feed',
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
                )));
  }
}

class QuestionFeed {
  final String title;
  final int score;

  QuestionFeed(this.title, this.score);
}
