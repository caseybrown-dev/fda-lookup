import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

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
              width: windowWidth * 0.5,
              height: 50,
              child: const TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  )
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: windowWidth * 0.5,
              height: 50,
              child: ElevatedButton(
                style: style,
                onPressed: () {},
                child: const Text('Search'),
              ),
            )
          ],
        ),
      );
  }
}
