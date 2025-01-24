import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/conditions_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputText.dart';

class ModalEditCondition extends StatefulWidget {
  const ModalEditCondition({super.key, required this.idCondition});

  final int idCondition;

  @override
  State<ModalEditCondition> createState() => _ModalEditConditionState();
}

class _ModalEditConditionState extends State<ModalEditCondition> {
  ConditionsRepository conditions_repository = ConditionsRepository();

  final _nameConditionController = TextEditingController();
  final _descriptionConditionController = TextEditingController();

  String? _nameConditionError;
  String? _descriptionConditionError;

  late String initialName;

  @override
  void initState() {
    super.initState();

    _loadCondition();

    setState(() {
      _nameConditionController.addListener(() {
        _clearErrorMessage(_nameConditionError);
      });

      _descriptionConditionController.addListener(() {
        _clearErrorMessage(_descriptionConditionError);
      });
    });
  }

  _loadCondition() async {
    final condition =
        await conditions_repository.getConditionById(widget.idCondition);
    setState(() {
      initialName = condition[0]['name_id'];
      _nameConditionController.text = condition[0]['name_id'];
      _descriptionConditionController.text = condition[0]['description'];
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

  void _updateCondition() async {
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

      if (initialName != name) {
        for (final condition in conditions) {
          if (condition['name_id'] == name) {
            setState(() {
              _nameConditionError = 'Condição ja cadastrada';
            });
            return;
          }
        }
      }

      var updatedCondition = {
        'name_id': name,
        'description': description,
      };

      await conditions_repository.updateCondition(
          widget.idCondition, updatedCondition);

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
              'Editar condição',
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
                    _updateCondition();
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
