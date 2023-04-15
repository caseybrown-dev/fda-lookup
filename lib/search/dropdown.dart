import 'package:fda_lookup/search/search_type.dart';
import 'package:flutter/material.dart';

List<SearchType> list = SearchType.values;

class SearchModeDropdownButton extends StatefulWidget {

  final Function(SearchType) onChanged;

  const SearchModeDropdownButton({super.key, required this.onChanged});

  @override
  State<SearchModeDropdownButton> createState() => _SearchModeDropdownButtonState();
}

class _SearchModeDropdownButtonState extends State<SearchModeDropdownButton> {

  SearchType dropdownValue = SearchType.values.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SearchType>(
      value: dropdownValue,

      // icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      // style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (SearchType? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChanged(dropdownValue);
        });
      },
      items: list.map<DropdownMenuItem<SearchType>>((SearchType value) {
        return DropdownMenuItem<SearchType>(
          value: value,
          child: Text(value.displayName),
        );
      }).toList(),
    );
  }
}
