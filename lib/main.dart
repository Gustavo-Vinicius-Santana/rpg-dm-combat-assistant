import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/Character/CharacterEditScreen.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/Character/CharacterRegister.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/Combat/CombatEditScreen.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/Combat/CombatRegister.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/Combat/CombatScreen.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/Conditions/ManagePersonConditionScreen.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/Monster/MonsterEditScreen.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/Monster/MonsterRegister.dart';
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
        // ROTAS PERSONAGEM
        '/characterRegister': (context) => CharacterRegister(),
        '/characterEdit': (context) => CharacterEditScreen(),

        // ROTAS MONSTRO
        '/monsterRegister': (context) => MonsterRegister(),
        '/mosterEdit': (context) => MonsterEditScreen(),

        //ROTAS COMBATE
        '/combatScreen': (context) => CombatScreen(),
        '/combatEdit': (context) => CombatEditScreen(),
        '/combatRegister': (context) => CombatRegister(),

        //ROTAS CONDITIONS
        '/managePersonConditionScreen': (context) =>
            ManagePersonConditionScreen(),
      },
    );
  }
}
