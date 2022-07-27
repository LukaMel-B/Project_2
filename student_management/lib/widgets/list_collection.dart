import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final ValueChanged<String> onChange;
  final String hint;
  const SearchWidget({Key? key, required this.onChange, required this.hint})
      : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        icon: const Icon(
          Icons.search,
          color: Colors.black,
          size: 25,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: widget.hint,
      ),
    );
  }
}
