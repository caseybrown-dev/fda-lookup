import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../search_type.dart';

class ResultCard extends StatelessWidget {

  final dynamic result;
  const ResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('${result!['brand_name']} (${result!['active_ingredients']![0]!['name']}) ${result!['active_ingredients']![0]!['strength']}'),
            // Text(result.toString())
            Text('NDC9: ${result!['product_ndc']}', textAlign: TextAlign.left),
            Text(
                'Labeler Name: ${result!['labeler_name']}'),
            // Text('Brand Name: ${result!['brand_name']}', textAlign: TextAlign.justify),
            // Text(
            //     'Generic Name: ${result!['generic_name']}', textAlign: TextAlign.justify),
            // Text('Active Ingredient: ${result!['product_ndc']}'),
            // Text('Strength: ${result!['active_ingredients']![0]!['strength']}', textAlign: TextAlign.justify),
            ...result!['packaging'].map((packaging) => Text(packaging['description'], textAlign: TextAlign.justify)).toList()
          ],
        ));
  }
  }