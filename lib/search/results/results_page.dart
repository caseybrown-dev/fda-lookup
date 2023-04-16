import 'dart:convert';

import 'package:fda_lookup/search/results/results_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../search_type.dart';

class ResultsPage extends StatefulWidget {
  final String ndcApiEndpoint = 'https://api.fda.gov/drug/ndc.json';

  final SearchType searchType;
  final String input;
  final bool exact;

  const ResultsPage(
      {super.key,
      required this.searchType,
      required this.input,
      required this.exact});

  @override
  State<StatefulWidget> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late Future<List<dynamic>> futureDrugs;

  Future<List<dynamic>> fetchDrugs() async {
    String queryParam = '?search=';

    String input = widget.input.replaceAll(" ", "+");
    if (widget.exact) {
      queryParam += '${widget.searchType.param}:"${widget.input}"';
    } else {
      queryParam += '${widget.searchType.param}:${widget.input}';
    }
    queryParam += '&limit=1000';

    final results = await fetchResults('${widget.ndcApiEndpoint}$queryParam');

    results.sort((a, b) {
      String aBrandName = a!['brand_name'] ?? '';
      String bBrandName = b!['brand_name'] ?? '';
      if (aBrandName.isNotEmpty &&
          bBrandName.isNotEmpty &&
          aBrandName != bBrandName) {
        return aBrandName.compareTo(bBrandName);
      }
      String aGenericName = a!['generic_name'] ?? '';
      String bGenericName = b!['generic_name'] ?? '';
      if (aGenericName.isNotEmpty &&
          bGenericName.isNotEmpty &&
          aGenericName != bGenericName) {
        return aGenericName.compareTo(bGenericName);
      }

      String aNdc = a!['product_ndc'] ?? '';
      String bNdc = b!['product_ndc'] ?? '';
      return aNdc.compareTo(bNdc);
    });

    return results;
  }

  Future<List<dynamic>> fetchResults(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> results = jsonDecode(response.body)['results'];

      // Results will only be fetched 1000 at a time, this will send the paginated requests
      if (response.headers['link'] != null) {
        String url = response.headers['link']!;
        url = url.split(';')[0];
        url = url.substring(1, url.length - 1);
        List<dynamic> nextResults = await fetchResults(url);
        results.addAll(nextResults);
      }

      return results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('No matching drugs found');
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
          FutureBuilder<List<dynamic>>(
            future: futureDrugs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> results = snapshot.data!;
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