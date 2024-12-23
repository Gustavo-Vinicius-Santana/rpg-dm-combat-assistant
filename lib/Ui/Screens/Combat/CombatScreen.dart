import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/combats_repository.dart';

class CombatScreen extends StatefulWidget {
  const CombatScreen({super.key});

  @override
  State<CombatScreen> createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  final CombatsRepository _combatsRepository = CombatsRepository();
  late final String _title;
  late final String _time;
  late final int _turns;

  int? id;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is int) {
      id = arguments;
      _loadCombat(id!);
    } else {
      throw Exception("ID não fornecido ou inválido");
    }
  }

  void _loadCombat(int id) async {
    print('id fornecido pela rota: $id');
    final combat = await _combatsRepository.getCombatById(id);
    print(combat);
    setState(() {
      _title = combat[0]['name'];
      _time = combat[0]['time'];
      _turns = combat[0]['turns'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Turnos: $_turns'),
              Text('Tempo: $_time'),
            ],
          )
        ],
      ),
    );
  }
}
