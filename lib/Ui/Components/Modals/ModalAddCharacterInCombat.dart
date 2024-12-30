import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListPersonWIthAtributes.dart';

class ModalAddCharacterInCombat extends StatefulWidget {
  const ModalAddCharacterInCombat({super.key, required this.combatId});

  final int combatId;

  @override
  State<ModalAddCharacterInCombat> createState() =>
      _ModalAddCharacterInCombatState();
}

class _ModalAddCharacterInCombatState extends State<ModalAddCharacterInCombat> {
  @override
  Widget build(BuildContext context) {
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
              child: const ListPersonWithAtributes(
                  itemsList: [],
                  selectIcon: 0,
                  emptyList: 'Nenhum personagem cadastrada'),
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
                  onPressed: () {
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
