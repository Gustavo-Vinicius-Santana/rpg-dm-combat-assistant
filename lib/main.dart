import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/CharacterEditScreen.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/CharacterRegister.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/MonsterRegister.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => MyHomePage(),
        '/characterRegister': (context) => CharacterRegister(),
        '/characterEdit': (context) => CharacterEditScreen(),
        '/monsterRegister': (context) => MonsterRegister(),
      },
    );
  }
}
