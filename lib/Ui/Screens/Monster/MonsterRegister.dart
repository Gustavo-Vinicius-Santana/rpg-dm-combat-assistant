import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monsters_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonFormConfirm.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputText.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputNumberInt.dart';

class MonsterRegister extends StatefulWidget {
  const MonsterRegister({super.key});

  @override
  State<MonsterRegister> createState() => _MonsterRegisterState();
}

class _MonsterRegisterState extends State<MonsterRegister> {
  final MonstersRepository _monsterRepository = MonstersRepository();
  final TextEditingController _nameMonsterController = TextEditingController();
  final TextEditingController _armorController = TextEditingController();
  final TextEditingController _maxHealthController = TextEditingController();
  final TextEditingController _minHealthController = TextEditingController();

  String? _messageErrorNameMonster;
  String? _messageErrorArmor;
  String? _messageErrorMaxHealth;
  String? _messageErrorMinHealth;

  @override
  void initState() {
    super.initState();
    _nameMonsterController.addListener(() {
      _clearErrorMessage(_messageErrorNameMonster);
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
      if (_nameMonsterController.text.isNotEmpty) {
        _messageErrorNameMonster = null;
      }
      if (_armorController.text.isNotEmpty) {
        _messageErrorArmor = null;
      }
      if (_maxHealthController.text.isNotEmpty) {
        _messageErrorMaxHealth = null;
      }
      if (_minHealthController.text.isNotEmpty) {
        _messageErrorMinHealth = null;
      }
    });
  }

  void _registerMonster() async {
    final nameMonster = _nameMonsterController.text;
    final armor = _armorController.text;
    final maxHealth = _maxHealthController.text;
    final minHealth = _minHealthController.text;

    if (nameMonster.isEmpty ||
        armor.isEmpty ||
        maxHealth.isEmpty ||
        minHealth.isEmpty) {
      setState(() {
        _messageErrorNameMonster =
            nameMonster.isEmpty ? 'campo obrigatório.' : null;
        _messageErrorArmor = armor.isEmpty ? 'campo obrigatório.' : null;
        _messageErrorMaxHealth =
            maxHealth.isEmpty ? 'campo obrigatório.' : null;
        _messageErrorMinHealth =
            minHealth.isEmpty ? 'campo obrigatório.' : null;
      });
    } else {
      // Montando o mapa com os dados do personagem
      Map<String, dynamic> monster = {
        'name': nameMonster,
        'armor': armor,
        'lifeMax': int.parse(maxHealth),
        'lifeActual': int.parse(minHealth),
      };

      try {
        final id = await _monsterRepository.insertMonster(monster);
        print("Personagem cadastrado com sucesso! ID: $id");

        // Limpando os campos após o registro
        _nameMonsterController.clear();
        _armorController.clear();
        _maxHealthController.clear();
        _minHealthController.clear();

        setState(() {
          _messageErrorNameMonster = null;
          _messageErrorArmor = null;
          _messageErrorMaxHealth = null;
          _messageErrorMinHealth = null;
        });

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
          arguments: 2,
        );
      } catch (e) {
        print("Erro ao registrar personagem: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
          arguments: 2,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar monstro'),
        ),
        body: Center(
          child: Column(
            children: [
              Center(
                child: InputText(
                  controller: _nameMonsterController,
                  maxLength: 20,
                  errorMessage: _messageErrorNameMonster,
                  placeholder: 'Nome do monstro',
                  label: 'MONSTRO',
                ),
              ),
              const SizedBox(height: 20),
              InputNumberInt(
                controller: _armorController,
                errorMessage: _messageErrorArmor,
                label: 'ARMADURA',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InputNumberInt(
                    controller: _maxHealthController,
                    errorMessage: _messageErrorMaxHealth,
                    label: 'VIDA MAXIMA',
                  ),
                  InputNumberInt(
                    controller: _minHealthController,
                    errorMessage: _messageErrorMinHealth,
                    label: 'VIDA MINIMA',
                  )
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: ButtonFormConfirm(
                  register: _registerMonster,
                  textInButton: 'CADASTRAR',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
