import 'package:flutter/material.dart';
import 'Ui/Components/Icons/IconsSvg.dart';
import 'Ui/Screens/CharacterListScreen.dart';
import 'Ui/Screens/MonsterListScreen.dart';
import 'Ui/Screens/CombatListScreen.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _screens = [
      const Characterlistscreen(),
      const Combatlistscreen(),
      const Monsterlistscreen(),
    ];
  }

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> _screens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'ASSISTENTE DE COMBATES',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: AppIcons.personagemIcon(selectedIndex: _selectedIndex),
            label: 'Personagens',
          ),
          BottomNavigationBarItem(
            icon: AppIcons.combateIcon(selectedIndex: _selectedIndex),
            label: 'Combates',
          ),
          BottomNavigationBarItem(
            icon: AppIcons.monstroIcon(selectedIndex: _selectedIndex),
            label: 'Monstros',
          ),
        ],
        unselectedLabelStyle:
            const TextStyle(color: Colors.black, fontSize: 15.0),
        selectedLabelStyle: const TextStyle(fontSize: 17.0),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemSelected,
      ),
    );
  }
}
