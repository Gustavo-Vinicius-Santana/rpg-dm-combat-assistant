import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonFormConfirm.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputText.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputNumberInt.dart';

class CharacterRegister extends StatefulWidget {
  const CharacterRegister({super.key});

  @override
  State<CharacterRegister> createState() => _CharacterRegisterState();
}

class _CharacterRegisterState extends State<CharacterRegister> {
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

  void _registerCharacter() {
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
      // Lógica para registrar o personagem
      print("Personagem registrado com sucesso!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
