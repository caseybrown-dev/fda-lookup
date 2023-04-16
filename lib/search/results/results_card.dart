import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../search_type.dart';

class ResultCard extends StatelessWidget {

  final dynamic result;
  const ResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    if (result == null ){
      return const SizedBox.shrink();
    }

    String title = '';
    String subtitle = '';

    var brandName = result!['brand_name'];
    var activeIngredients = result!['active_ingredients'];
    if (activeIngredients != null) {
      if (brandName != null) {
        title = '$brandName ${activeIngredients![0]!['strength']}';
        subtitle = activeIngredients![0]!['name'];
      } else {
        title = '${activeIngredients![0]!['name']} ${activeIngredients![0]!['strength']}';
      }
    } else {
      if (brandName != null) {
        title = brandName;
        subtitle = result!['generic_name'];
      } else {
        title = result!['generic_name'];
      }
    }

    return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              // leading: Icon(Icons.album),
              title: Text(title),
              subtitle: subtitle.isEmpty ? const SizedBox.shrink() : Text(subtitle),
            ),
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