import 'package:flutter/material.dart';
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
  });

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
            Text(
              'Editar ${widget.personName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 16),
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
                  controller: _minHealthController,
                  label: 'Vida Atual',
                  errorMessage: _messageErrorMinHealth,
                ),
                InputNumberInt(
                  controller: _maxHealthController,
                  label: 'Vida Máxima',
                  errorMessage: _messageErrorMaxHealth,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Condições: ${widget.personConditions.join(', ')}'),
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
