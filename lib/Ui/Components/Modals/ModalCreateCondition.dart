import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/conditions_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputText.dart';

class ModalCreateCondition extends StatefulWidget {
  const ModalCreateCondition({super.key, required this.personId});
  final int personId;

  @override
  State<ModalCreateCondition> createState() => _ModalCreateConditionState();
}

class _ModalCreateConditionState extends State<ModalCreateCondition> {
  ConditionsRepository conditions_repository = ConditionsRepository();

  final _nameConditionController = TextEditingController();
  final _descriptionConditionController = TextEditingController();

  String? _nameConditionError;
  String? _descriptionConditionError;

  @override
  void initState() {
    super.initState();

    setState(() {
      _nameConditionController.addListener(() {
        _clearErrorMessage(_nameConditionError);
      });

      _descriptionConditionController.addListener(() {
        _clearErrorMessage(_descriptionConditionError);
      });
    });
  }

  void _clearErrorMessage(String? errorMessage) {
    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }

    setState(() {
      if (_nameConditionController.text.isNotEmpty) {
        _nameConditionError = null;
      }
      if (_descriptionConditionController.text.isNotEmpty) {
        _descriptionConditionError = null;
      }
    });
  }

  void _createCondition() async {
    final name = _nameConditionController.text;
    final description = _descriptionConditionController.text;

    if (name.isEmpty || description.isEmpty) {
      setState(() {
        _nameConditionError = name.isEmpty ? 'Campo obrigatório.' : null;
        _descriptionConditionError =
            description.isEmpty ? 'Campo obrigatório.' : null;
      });
    } else {
      print('criando condição');

      List<Map<String, dynamic>> conditions =
          await conditions_repository.getAllConditions();

      for (final condition in conditions) {
        if (condition['name_id'] == name) {
          setState(() {
            _nameConditionError = 'Condição ja cadastrada';
          });
          return;
        }
      }

      var newCondition = {
        'name_id': name,
        'description': description,
      };

      await conditions_repository.insertCondition(newCondition);

      Navigator.of(context).pop();
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
            const Text(
              'Criar condição',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 8),
            InputText(
              controller: _nameConditionController,
              maxLength: 20,
              placeholder: 'Digite o nome da condição',
              label: 'NOME',
              errorMessage: _nameConditionError,
            ),
            const SizedBox(height: 8),
            InputText(
              controller: _descriptionConditionController,
              maxLength: 60,
              placeholder: 'digite a condição',
              label: 'DESCRIÇÃO',
              errorMessage: _descriptionConditionError,
            ),
            const SizedBox(height: 16),
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
                    _createCondition();
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
