import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monster_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAction.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputNumberInt.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputText.dart';

class ModalEditPerson extends StatefulWidget {
  const ModalEditPerson({
    super.key,
    required this.personName,
    required this.personIniciative,
    required this.personLifeMax,
    required this.personLifeActual,
    required this.personArmor,
    required this.personConditions,
    required this.personId,
    required this.personType,
    required this.combatId,
  });
  final int personId;
  final int combatId;
  final String personType;
  final String personName;
  final int personIniciative;
  final int personLifeMax;
  final int personLifeActual;
  final String personArmor;
  final List personConditions;

  @override
  _ModalEditPersonState createState() => _ModalEditPersonState();
}

class _ModalEditPersonState extends State<ModalEditPerson> {
  final MonsterInCombatRepository monster_repository =
      MonsterInCombatRepository();

  final CharacterInCombatRepository character_repository =
      CharacterInCombatRepository();

  final _namePersonController = TextEditingController();
  final _iniciativeController = TextEditingController();
  final _armorController = TextEditingController();
  final _maxHealthController = TextEditingController();
  final _minHealthController = TextEditingController();

  String? _messageErrorNamePerson;
  String? _messageErrorIniciative;
  String? _messageErrorArmor;
  String? _messageErrorMaxHealth;
  String? _messageErrorMinHealth;

  @override
  void initState() {
    super.initState();

    // Inicializar os controladores com os valores iniciais
    _namePersonController.text = widget.personName;
    _iniciativeController.text = widget.personIniciative.toString();
    _armorController.text = widget.personArmor;
    _maxHealthController.text = widget.personLifeMax.toString();
    _minHealthController.text = widget.personLifeActual.toString();

    // Adicionar listeners aos controladores
    _namePersonController.addListener(() {
      _clearErrorMessage(_messageErrorNamePerson);
    });
    _iniciativeController.addListener(() {
      _clearErrorMessage(_messageErrorIniciative);
    });
    _armorController.addListener(() {
      _clearErrorMessage(_messageErrorArmor);
    });
    _maxHealthController.addListener(() {
      _clearErrorMessage(_messageErrorMaxHealth);
    });
    _minHealthController.addListener(() {
      _clearErrorMessage(_messageErrorMinHealth);
    });
  }

  void _clearErrorMessage(String? errorMessage) {
    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }

    setState(() {
      if (_namePersonController.text.isNotEmpty) {
        _messageErrorNamePerson = null;
      }
      if (_armorController.text.isNotEmpty) {
        _messageErrorArmor = null;
      }
      if (_maxHealthController.text.isNotEmpty &&
          int.tryParse(_maxHealthController.text) != null &&
          int.parse(_maxHealthController.text) > 0) {
        _messageErrorMaxHealth = null;
      }
      if (_minHealthController.text.isNotEmpty &&
          int.tryParse(_minHealthController.text) != null &&
          int.parse(_minHealthController.text) >= 0) {
        _messageErrorMinHealth = null;
      }
      if (_iniciativeController.text.isNotEmpty &&
          int.tryParse(_iniciativeController.text) != null &&
          int.parse(_iniciativeController.text) >= 0) {
        _messageErrorIniciative = null;
      }
    });
  }

  void _updatePerson() async {
    final type = widget.personType;
    final name = _namePersonController.text;
    final iniciative = _iniciativeController.text;
    final armor = _armorController.text;
    final maxHealth = _maxHealthController.text;
    final minHealth = _minHealthController.text;

    if (name.isEmpty ||
        iniciative.isEmpty ||
        armor.isEmpty ||
        maxHealth.isEmpty ||
        minHealth.isEmpty) {
      setState(() {
        _messageErrorNamePerson = name.isEmpty ? 'Campo obrigatório.' : null;
        _messageErrorIniciative =
            iniciative.isEmpty ? 'Campo obrigatório.' : null;
        _messageErrorArmor = armor.isEmpty ? 'Campo obrigatório.' : null;
        _messageErrorMaxHealth =
            maxHealth.isEmpty ? 'Campo obrigatório.' : null;
        _messageErrorMinHealth =
            minHealth.isEmpty ? 'Campo obrigatório.' : null;
      });
    } else {
      Map<String, dynamic> personEdited = {
        'name': name,
        'iniciative': int.parse(iniciative),
        'armor': armor,
        'lifeMax': int.parse(maxHealth),
        'lifeActual': int.parse(minHealth),
      };

      try {
        if (type == 'character') {
          await character_repository.updateCharacterInCombat(
              widget.personId, personEdited);
          print("Personagem editado com sucesso! ID: ${widget.personId}");
        }

        if (type == 'monster') {
          await monster_repository.updateMonsterInCombat(
              widget.personId, personEdited);
          print("Personagem editado com sucesso! ID: ${widget.personId}");
        }

        Navigator.pushReplacementNamed(
          context,
          '/combatScreen',
          arguments: widget.combatId,
        );
      } catch (e) {
        print(e);
      }
    }
  }

  void _deletePerson() async {
    try {
      if (widget.personType == 'character') {
        await character_repository.deleteCharacterInCombat(widget.personId);
        print("Personagem deletado com sucesso! ID: ${widget.personId}");
      }

      if (widget.personType == 'monster') {
        await monster_repository.deleteMonsterInCombat(widget.personId);
        print("Personagem deletado com sucesso! ID: ${widget.personId}");
      }

      Navigator.pushReplacementNamed(
        context,
        '/combatScreen',
        arguments: widget.combatId,
      );
    } catch (e) {
      print(e);
    }
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Editar personagem',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.grey,
                    size: 24.0,
                  ),
                  onPressed: () {
                    _deletePerson();
                  },
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'ATRIBUTOS',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            InputText(
              controller: _namePersonController,
              label: 'NOME',
              errorMessage: _messageErrorNamePerson,
              maxLength: 20,
              placeholder: 'Nome do personagem',
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputNumberInt(
                  controller: _iniciativeController,
                  label: 'INICIATIVA',
                  errorMessage: _messageErrorIniciative,
                ),
                InputNumberInt(
                  controller: _armorController,
                  label: 'ARMADURA',
                  errorMessage: _messageErrorArmor,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputNumberInt(
                  controller: _maxHealthController,
                  label: 'Vida Máxima',
                  errorMessage: _messageErrorMaxHealth,
                ),
                InputNumberInt(
                  controller: _minHealthController,
                  label: 'Vida Atual',
                  errorMessage: _messageErrorMinHealth,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'CONDIÇÕES',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.personConditions.isNotEmpty) ...[
                      for (var condition in widget.personConditions)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
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
                        ),
                    ] else
                      const Text(
                        "Não há condições",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.personConditions.length >= 4)
                      ButtonAction(
                        onPressed: () {
                          print('remover condição');
                        },
                        textInButton: 'remover',
                      ),
                    if (widget.personConditions.length < 4) ...[
                      ButtonAction(
                        onPressed: () {
                          print('adicionar condição');
                        },
                        textInButton: 'adicionar',
                      ),
                      if (widget.personConditions.isNotEmpty)
                        ButtonAction(
                          onPressed: () {
                            print('remover condição');
                          },
                          textInButton: 'remover condição',
                        ),
                    ],
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
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
                    _updatePerson();

                    // Navigator.of(context).pop();
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
