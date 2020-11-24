import 'package:dictionary/models/definition_response.dart';
import 'package:flutter/material.dart';

class EntryCard extends StatelessWidget {
  final LexicalEntry entry;
  EntryCard({Key key, @required this.entry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(entry.language),
    );
  }
}
