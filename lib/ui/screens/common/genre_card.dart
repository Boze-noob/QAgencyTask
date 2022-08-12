import 'package:flutter/material.dart';
import 'package:q_agency_task/_all.dart';

class GenreCard extends StatelessWidget {
  String title = "";

  GenreCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
