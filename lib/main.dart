import 'package:flutter/material.dart';
import 'package:guessthenumber/home.dart';

void main() {
  runApp(const GuessTheNumber());
}

class GuessTheNumber extends StatelessWidget {
  const GuessTheNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "UbuntuMono"),
      title: "U Guess",
      home: const SafeArea(child: HomeView()),
    );
  }
}
