import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;

  const JokeCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () => onTap(),
      ),
    );
  }
}
