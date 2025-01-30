import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/Character_conditions_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/Monster_conditions_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monster_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAction.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputNumberInt.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputText.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListSimpleConditions.dart';

class ModalEditPerson extends StatefulWidget {
  const ModalEditPerson({
    super.key,
    required this.personId,
    required this.personType,
    required this.combatId,
  });
  final int personId;
  final int combatId;
  final String personType;

  @override
  _ModalEditPersonState createState() => _ModalEditPersonState();
}

class _ModalEditPersonState extends State<ModalEditPerson> {
  final MonsterInCombatRepository monster_repository =
      MonsterInCombatRepository();
  final CharacterConditionsRepository character_conditions_repository =
      CharacterConditionsRepository();
  final MonsterConditionsRepository monster_conditions_repository =
      MonsterConditionsRepository();

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

  List<Map<String, dynamic>> _conditions = [];

  @override
  void initState() {
    super.initState();
    _loadPerson(widget.personId);

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

  void _loadPersonCondition(type, id) async {
    if (type == 'character') {
      final conditions =
          await character_conditions_repository.getCharacterConditions(id);

      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      print(conditions);

      setState(() {
        _conditions = conditions;
      });
    }

    if (type == 'monster') {
      final conditions =
          await monster_conditions_repository.getMonsterConditions(id);

      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      print(conditions);

      setState(() {
        _conditions = conditions;
      });
    }
  }

  void _loadPerson(personId) async {
    print("Carregando personagem de ID: $personId");
    try {
      if (widget.personType == 'character') {
        final character =
            await character_repository.getCharacterInCombatById(personId);

        _loadPersonCondition('character', personId);
        setState(() {
          _namePersonController.text = character[0]['name'];
          _iniciativeController.text = character[0]['iniciative'].toString();
          _armorController.text = character[0]['armor'];
          _maxHealthController.text = character[0]['lifeMax'].toString();
          _minHealthController.text = character[0]['lifeActual'].toString();
        });
      } else if (widget.personType == 'monster') {
        final monster =
            await monster_repository.getMonsterInCombatById(personId);

        _loadPersonCondition('monster', personId);
        setState(() {
          _namePersonController.text = monster[0]['name'];
          _iniciativeController.text = monster[0]['iniciative'].toString();
          _armorController.text = monster[0]['armor'];
          _maxHealthController.text = monster[0]['lifeMax'].toString();
          _minHealthController.text = monster[0]['lifeActual'].toString();
        });
      }
    } catch (e) {
      print('Erro ao carregar o personagem: $e');
    }
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

  void _goToManegePersonConditions() {
    print("Ir para tela de adicionar condições");

    Navigator.pushNamed(
      context,
      '/managePersonConditionScreen',
      arguments: {
        'id': widget.personId,
        'type': widget.personType,
      },
    );
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
                    ButtonAction(
                      fontSize: 14,
                      width: 180,
                      height: 30,
                      onPressed: () {
                        _goToManegePersonConditions();
                      },
                      textInButton: 'Gerenciar condições',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 275,
                      height: 200,
                      child:
                          ListSimpleConditions(personConditions: _conditions),
                    ),
                  ],
                ),
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
