import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonFormConfirm.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputText.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputNumberInt.dart';
import 'package:rpg_dm_combat_assistant/Data/Repositories/character_repository.dart';

class CharacterRegister extends StatefulWidget {
  const CharacterRegister({super.key});

  @override
  State<CharacterRegister> createState() => _CharacterRegisterState();
}

class _CharacterRegisterState extends State<CharacterRegister> {
  final CharacterRepository _characterRepository = CharacterRepository();
  final TextEditingController _namePlayerController = TextEditingController();
  final TextEditingController _nameCharacterController =
      TextEditingController();
  final TextEditingController _armorController = TextEditingController();
  final TextEditingController _maxHealthController = TextEditingController();
  final TextEditingController _minHealthController = TextEditingController();

  String? _messageErrorNamePlayer;
  String? _messageErrorNameCharacter;
  String? _messageErrorArmor;
  String? _messageErrorMaxHealth;
  String? _messageErrorMinHealth;

  @override
  void initState() {
    super.initState();
    _namePlayerController.addListener(() {
      _clearErrorMessage(_messageErrorNamePlayer);
    });
    _nameCharacterController.addListener(() {
      _clearErrorMessage(_messageErrorNameCharacter);
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
      if (_namePlayerController.text.isNotEmpty) {
        _messageErrorNamePlayer = null;
      }
      if (_nameCharacterController.text.isNotEmpty) {
        _messageErrorNameCharacter = null;
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

  void _registerCharacter() async {
    final namePlayer = _namePlayerController.text;
    final nameCharacter = _nameCharacterController.text;
    final armor = _armorController.text;
    final maxHealth = _maxHealthController.text;
    final minHealth = _minHealthController.text;

    if (namePlayer.isEmpty ||
        nameCharacter.isEmpty ||
        armor.isEmpty ||
        maxHealth.isEmpty ||
        minHealth.isEmpty) {
      setState(() {
        _messageErrorNamePlayer =
            namePlayer.isEmpty ? 'campo obrigatório.' : null;
        _messageErrorNameCharacter =
            nameCharacter.isEmpty ? 'campo obrigatório.' : null;
        _messageErrorArmor = armor.isEmpty ? 'campo obrigatório.' : null;
        _messageErrorMaxHealth =
            maxHealth.isEmpty ? 'campo obrigatório.' : null;
        _messageErrorMinHealth =
            minHealth.isEmpty ? 'campo obrigatório.' : null;
      });
    } else {
      // Montando o mapa com os dados do personagem
      Map<String, dynamic> character = {
        'player': namePlayer,
        'name': nameCharacter,
        'armor': armor,
        'lifeMax': int.parse(maxHealth),
        'lifeActual': int.parse(minHealth),
        'condition_1': 'alive',
        'condition_2': 'alive',
        'condition_3': 'alive',
        'condition_4': 'alive',
      };

      try {
        // Inserindo no banco de dados
        final id = await _characterRepository.insertCharacter(character);
        print("Personagem registrado com sucesso! ID: $id");

        // Limpando os campos após o registro
        _namePlayerController.clear();
        _nameCharacterController.clear();
        _armorController.clear();
        _maxHealthController.clear();
        _minHealthController.clear();

        setState(() {
          _messageErrorNamePlayer = null;
          _messageErrorNameCharacter = null;
          _messageErrorArmor = null;
          _messageErrorMaxHealth = null;
          _messageErrorMinHealth = null;
        });

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
          arguments: 0,
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
          arguments: 0,
        );
        return false; // Impede o comportamento padrão de voltar
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar personagem'),
        ),
        body: Center(
          child: Column(
            children: [
              Center(
                child: InputText(
                  controller: _namePlayerController,
                  maxLength: 20,
                  errorMessage: _messageErrorNamePlayer,
                  placeholder: 'Nome do jogador',
                  label: 'JOGADOR',
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: InputText(
                  controller: _nameCharacterController,
                  maxLength: 20,
                  errorMessage: _messageErrorNameCharacter,
                  placeholder: 'Nome do personagem',
                  label: 'PERSONAGEM',
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
                  register: _registerCharacter,
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
