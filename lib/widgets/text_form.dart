import 'package:flutter/material.dart';

class TextForm extends StatefulWidget {
  TextForm({
    required TextEditingController dataController,
    required String title,
  })  : _dataController = dataController,
        _title = title;

  final TextEditingController _dataController;
  final String _title;

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._dataController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget._title,
      ),
    );
  }
}
