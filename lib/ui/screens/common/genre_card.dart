import 'package:flutter/material.dart';

class GenreCard extends StatelessWidget {
  String title = "";
  EdgeInsets edgeInsets;

  GenreCard({Key? key, required this.title, required this.edgeInsets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: edgeInsets,
            child: Text(
              title,
              style: const TextStyle(fontSize: 11),
            ),
          ),
        )
      ],
    );
  }
}
