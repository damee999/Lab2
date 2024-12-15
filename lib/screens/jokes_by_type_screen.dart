import 'package:flutter/material.dart';
import 'package:untitled8/services/api_services.dart';
import 'package:untitled8/models/joke.dart';

class JokesByTypeScreen extends StatelessWidget {
  final String type;
  final ApiServices apiServices = ApiServices();

  JokesByTypeScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$type Jokes")),
      body: FutureBuilder<List<Joke>>(
        future: apiServices.fetchJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(jokes[index].setup),
                  subtitle: Text(jokes[index].punchline),
                );
              },
            );
          }
          return Center(child: Text('No jokes found'));
        },
      ),
    );
  }
}
