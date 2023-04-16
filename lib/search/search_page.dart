import 'package:fda_lookup/search/dropdown.dart';
import 'package:fda_lookup/search/results/results_page.dart';
import 'package:fda_lookup/search/search_type.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  SearchType searchType = SearchType.values.first;
  final inputFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    final double windowWidth = MediaQuery.of(context).size.width;

    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              width: windowWidth * 0.25,
              height: 50,
              child: SearchModeDropdownButton(
                  onChanged: (SearchType value) => {searchType = value})),
          const SizedBox(height: 30),
          SizedBox(
            width: windowWidth * 0.5,
            height: 50,
            child:  TextField(
              controller: inputFieldController,
              obscureText: false,
                decoration: const InputDecoration(border: OutlineInputBorder()),
          )),
          const SizedBox(height: 30),
          SizedBox(
            width: windowWidth * 0.5,
            height: 50,
            child: ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultsPage(searchType: searchType, input: inputFieldController.text,)),
                );
              },
              child: const Text('Search'),
            ),
          )
        ],
      ),
    );
  }
}
