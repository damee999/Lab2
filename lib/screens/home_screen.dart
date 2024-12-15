import 'package:flutter/material.dart';
import 'package:untitled8/services/api_services.dart';
import 'package:untitled8/widgets/joke_card.dart';
import 'package:untitled8/screens/jokes_by_type_screen.dart';
import 'package:untitled8/screens/random_joke_screen.dart';

class HomeScreen extends StatelessWidget {
  final ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jokes App"),
        actions: [
          IconButton(
            icon: Icon(Icons.casino),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RandomJokeScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: apiServices.fetchJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var jokeTypes = snapshot.data!;
            return ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeCard(
                  title: jokeTypes[index],
                  subtitle: 'Tap to see jokes',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokesByTypeScreen(type: jokeTypes[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
          return Center(child: Text('No data'));
        },
      ),
    );
  }
}
