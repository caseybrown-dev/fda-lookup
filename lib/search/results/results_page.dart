import 'dart:convert';

import 'package:fda_lookup/search/results/results_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../search_type.dart';

class ResultsPage extends StatefulWidget {
  final String ndcApiEndpoint = 'https://api.fda.gov/drug/ndc.json';

  final SearchType searchType;
  final String input;

  const ResultsPage({super.key, required this.searchType, required this.input});

  @override
  State<StatefulWidget> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late Future<Map<String, dynamic>> futureDrugs;

  Future<Map<String, dynamic>> fetchDrugs() async {
    String queryParam = '?search=';
    queryParam += '${widget.searchType.param}:"${widget.input}"';
    queryParam += '&limit=5';
    final response =
        await http.get(Uri.parse('${widget.ndcApiEndpoint}$queryParam'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureDrugs = fetchDrugs();
  }

  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.searchType.displayName}: ${widget.input}'),
      ),
      body: Center(
          child: ListView(
        children: <Widget>[
          FutureBuilder<Map<String, dynamic>>(
            future: futureDrugs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> results = snapshot.data!['results'];
                return Column(
                    children: results
                        .map((result) => SizedBox(
                            width: windowWidth * 0.75,
                            child: ResultCard(result: result)))
                        .toList());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const LinearProgressIndicator();
            },
          )
        ],
      )),
    );
  }
}
