import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/Character_conditions_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/Monster_conditions_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Icons/IconsSvg.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Modals/ModalEditPerson.dart';

class CardPersonInCombat extends StatefulWidget {
  const CardPersonInCombat(
      {super.key,
      required this.name,
      required this.player,
      required this.armor,
      required this.lifeMax,
      required this.lifeActual,
      required this.type,
      required this.iniciative,
      required this.id,
      required this.combatId,
      required this.isTurn,
      this.infoOpenModal});
  final int id;
  final int combatId;
  final String name;
  final String player;
  final String type;
  final int iniciative;
  final String armor;
  final int lifeMax;
  final int lifeActual;

  final bool isTurn;

  final List<dynamic>? infoOpenModal;

  @override
  State<CardPersonInCombat> createState() => _CardPersonInCombatState();
}

class _CardPersonInCombatState extends State<CardPersonInCombat> {
  final CharacterConditionsRepository character_conditions_repository =
      CharacterConditionsRepository();
  final MonsterConditionsRepository monster_conditions_repository =
      MonsterConditionsRepository();

  List<String> _conditions = [];

  void _loadConditions(type, idPerson) async {
    if (type == 'character') {
      final conditionData = await character_conditions_repository
          .getCharacterConditions(idPerson);
      setState(() {
        _conditions = conditionData.map((e) => e['name_id'] as String).toList();
      });
    }

    if (type == 'monster') {
      final conditionData =
          await monster_conditions_repository.getMonsterConditions(idPerson);
      setState(() {
        _conditions = conditionData.map((e) => e['name_id'] as String).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _loadConditions(widget.type, widget.id);

    if (widget.infoOpenModal != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print("Conteúdo de infoOpenModal: ${widget.infoOpenModal}");
        if (widget.infoOpenModal?[0] == widget.id &&
            widget.infoOpenModal?[1] == widget.type) {
          openModal();
        } else {
          print('infoOpenModal contém valores inesperados ou inválidos!');
        }
      });
    }
  }

  void openModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalEditPerson(
          personId: widget.id,
          combatId: widget.combatId,
          personType: widget.type,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              if (widget.type == 'character' && widget.isTurn)
                AppIcons.jogadorCabecaIcon(color: Colors.blue)
              else if (widget.type == 'character')
                AppIcons.jogadorCabecaIcon()
              else if (widget.type == 'monster' && widget.isTurn)
                AppIcons.monstrosCabecaIcon(color: Colors.blue)
              else if (widget.type == 'monster')
                AppIcons.monstrosCabecaIcon(),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.grey),
                onPressed: () {
                  openModal();
                },
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "INICIATIVA",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  Text(
                    '${widget.iniciative}',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Container(
                height: 40.0,
                width: 1.0,
                color: Colors.grey,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ARMADURA",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  Text(
                    widget.armor,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Container(
                height: 40.0,
                width: 1.0,
                color: Colors.grey,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PV",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  Text(
                    "${widget.lifeActual}/${widget.lifeMax}",
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CONDIÇÕES',
                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                ],
              ),
              Wrap(
                spacing: 8, // Espaço horizontal entre os itens
                runSpacing: 8, // Espaço vertical entre as linhas
                alignment: WrapAlignment.center, // Centraliza os itens na linha
                children: _conditions.isNotEmpty
                    ? _conditions.map((condition) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            condition,
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList()
                    : [
                        const Text(
                          "Não há condições",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
