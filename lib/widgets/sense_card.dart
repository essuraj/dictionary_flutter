import 'package:dictionary/models/definition_response.dart';
import 'package:flutter/material.dart';

class SenseCard extends StatelessWidget {
  final Sense sense;
  SenseCard({Key key, @required this.sense}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ...sense.definitions.map((e) => ListTile(
                title: Text(e),
              ))
        ],
      ),
    );
  }
}
