import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monster_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monsters_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListPersonWIthAtributes.dart';

class ModalAddMonsterInCombat extends StatefulWidget {
  const ModalAddMonsterInCombat({super.key, required this.combatId});

  final int combatId;

  @override
  State<ModalAddMonsterInCombat> createState() =>
      _ModalAddMonsterInCombatState();
}

class _ModalAddMonsterInCombatState extends State<ModalAddMonsterInCombat> {
  final MonsterInCombatRepository _monstersInCombatRepository =
      MonsterInCombatRepository();
  final MonstersRepository _monstersRepository = MonstersRepository();

  List<Map<String, dynamic>> _monsters = [];

  @override
  void initState() {
    super.initState();
    print('estado iniciado');
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    try {
      final characters = await _monstersRepository.getAllMonsters();
      setState(() {
        _monsters = characters;
        print(_monsters);
      });
    } catch (e) {
      print('Erro ao carregar personagens: $e');
    }
  }

  Future<void> processSelectedIds(List<int> selectedIds, int combatId) async {
    for (final id in selectedIds) {
      try {
        final List<Map<String, dynamic>> monsterData =
            await _monstersRepository.getMonsterById(id);

        if (monsterData.isNotEmpty) {
          final monster = monsterData.first;

          // Prepara os dados para inserir na tabela 'monsters_participants'
          final Map<String, dynamic> monsterInCombat = {
            'combat_id': combatId,
            'monster_id': monster['id'],
            'name': monster['name'],
            'type': 'monster',
            'iniciative': monster['iniciative'] ?? 0,
            'armor': monster['armor'],
            'lifeMax': monster['lifeMax'],
            'lifeActual': monster['lifeActual'],
            'condition_1': monster['condition_1'],
            'condition_2': monster['condition_2'],
            'condition_3': monster['condition_3'],
            'condition_4': monster['condition_4'],
          };

          // Insere os dados no banco de dados
          await _monstersInCombatRepository
              .insertMonsterInCombat(monsterInCombat);
        } else {
          print('Nenhum dado encontrado para o ID $id');
        }
      } catch (e) {
        print('Erro ao processar ID $id: $e');
      }
    }

    print('Processamento concluído!');
  }

  @override
  Widget build(BuildContext context) {
    List<int> selectedIds = [];

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Adicionar monstro',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'LISTA DE MONSTROS',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListPersonWithAtributes(
                itemsList: _monsters,
                selectIcon: 1,
                emptyList: "Nenhum monstro encontrado",
                selectedIds: selectedIds,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    print(selectedIds);

                    final int combatId = widget.combatId;
                    await processSelectedIds(selectedIds, combatId);

                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
