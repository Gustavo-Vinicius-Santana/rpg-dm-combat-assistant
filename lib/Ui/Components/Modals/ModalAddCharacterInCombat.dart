import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListPersonWIthAtributes.dart';

class ModalAddCharacterInCombat extends StatefulWidget {
  const ModalAddCharacterInCombat({super.key, required this.combatId});

  final int combatId;

  @override
  State<ModalAddCharacterInCombat> createState() =>
      _ModalAddCharacterInCombatState();
}

class _ModalAddCharacterInCombatState extends State<ModalAddCharacterInCombat> {
  final CharacterRepository characterRepository = CharacterRepository();
  final CharacterInCombatRepository characterInCombatRepository =
      CharacterInCombatRepository();

  List<Map<String, dynamic>> _characters = [];

  @override
  void initState() {
    super.initState();
    print('estado iniciado');
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    try {
      final characters = await characterRepository.getAllCharacters();
      setState(() {
        _characters = characters;
        print(_characters);
      });
    } catch (e) {
      print('Erro ao carregar personagens: $e');
    }
  }

  Future<void> processSelectedIds(List<int> selectedIds, int combatId) async {
    for (final id in selectedIds) {
      try {
        final List<Map<String, dynamic>> characterData =
            await characterRepository.getCharacterById(id);

        if (characterData.isNotEmpty) {
          final character = characterData.first;

          // Prepara os dados para inserir na tabela 'monsters_participants'
          final Map<String, dynamic> characterInCombat = {
            'combat_id': combatId,
            'character_id': character['id'],
            'name': character['name'],
            'type': 'character',
            'player': character['player'],
            'iniciative': character['iniciative'] ?? 0,
            'armor': character['armor'],
            'lifeMax': character['lifeMax'],
            'lifeActual': character['lifeActual'],
          };

          // Insere os dados no banco de dados
          await characterInCombatRepository
              .insertCharacterInCombat(characterInCombat);
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
              'Adicionar personagem',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'LISTA DE PERSONAGENS',
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
                itemsList: _characters,
                selectIcon: 0,
                emptyList: "Nenhum personagem encontrado",
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
