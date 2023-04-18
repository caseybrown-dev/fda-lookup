import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../search_type.dart';

class ResultCard extends StatelessWidget {
  final dynamic result;
  const ResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return const SizedBox.shrink();
    }

    String title = '';
    String subtitle = '';

    var brandName = result!['brand_name'];
    var activeIngredients = result!['active_ingredients'];
    if (activeIngredients != null) {
      if (brandName != null) {
        title = '$brandName ${activeIngredients![0]!['strength']}';
        subtitle = '${activeIngredients![0]!['name']} - ';
      } else {
        title =
            '${activeIngredients![0]!['name']} ${activeIngredients![0]!['strength']}';
      }
    } else {
      if (brandName != null) {
        title = brandName;
        subtitle = '${result!['generic_name']} - ';
      } else {
        title = result!['generic_name'];
      }
    }

    subtitle += '${result!['labeler_name']}\n${result!['product_ndc']}';

    return Card(
        child: Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          // leading: Icon(Icons.album),
          leading: Tooltip(
            message: result!['dosage_form'],
            child: const Icon(Icons.local_pharmacy),
          ),
          title: Text(title),
          subtitle: subtitle.isEmpty ? const SizedBox.shrink() : Text(subtitle),
          isThreeLine: true,
          trailing: IconButton(
            icon: const Tooltip(
                message: 'Label Details', child: Icon(Icons.info)),
            onPressed: () {},
          ),
        ),
        Column(
          children: [
            ...result!['packaging']
                .map((packaging) => Card(
                    child: ListTile(
                        style: ListTileStyle.drawer,
                        title: Text(packaging!['description'],
                            textAlign: TextAlign.justify))))
                .toList()
          ],
        ),
      ],
    ));
  }
}
