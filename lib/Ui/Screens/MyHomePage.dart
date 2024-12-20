import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Icons/IconsSvg.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/Character/CharacterListScreen.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/CombatListScreen.dart';
import 'package:rpg_dm_combat_assistant/Ui/Screens/Monster/MonsterListScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const Characterlistscreen(),
      const Combatlistscreen(),
      const Monsterlistscreen(),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recuperando o argumento da rota, se disponível
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is int) {
      setState(() {
        _selectedIndex = arguments;
      });
    }
  }

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
