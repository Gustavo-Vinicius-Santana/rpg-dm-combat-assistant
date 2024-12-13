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
                controller: TextEditingController(),
                maxLength: 20,
                errorMessage: null,
                placeholder: 'Nome do jogador',
                label: 'JOGADOR',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: InputText(
                controller: TextEditingController(),
                maxLength: 20,
                errorMessage: null,
                placeholder: 'Nome do personagem',
                label: 'PERSONAGEM',
              ),
            ),
            const SizedBox(height: 20),
            InputNumberInt(
              controller: TextEditingController(),
              errorMessage: null,
              label: 'ARMADURA',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InputNumberInt(
                  controller: TextEditingController(),
                  errorMessage: null,
                  label: 'VIDA MAXIMA',
                ),
                InputNumberInt(
                  controller: TextEditingController(),
                  errorMessage: null,
                  label: 'VIDA MINIMA',
                )
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ButtonFormConfirm(
                register: () {},
                textInButton: 'CADASTRAR',
              ),
            )
          ],
        ),
      ),
    );
  }
}
