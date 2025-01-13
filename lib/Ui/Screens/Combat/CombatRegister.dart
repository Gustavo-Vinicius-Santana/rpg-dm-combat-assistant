import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/combats_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonFormConfirm.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputNumberInt.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputText.dart';

class CombatRegister extends StatefulWidget {
  const CombatRegister({super.key});

  @override
  State<CombatRegister> createState() => _CombatRegisterState();
}

class _CombatRegisterState extends State<CombatRegister> {
  CombatsRepository _combatsRepository = CombatsRepository();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _roundsController = TextEditingController();
  final TextEditingController _timeToNextTurnController =
      TextEditingController();

  String? _messageErrorName;
  String? _messageErrorTime;
  String? _messageErrorRounds;
  String? _messageErrorTimeToNextTurn;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() {
      _clearErrorMessage(_messageErrorName);
    });
    _timeController.addListener(() {
      _clearErrorMessage(_messageErrorTime);
    });
    _roundsController.addListener(() {
      _clearErrorMessage(_messageErrorRounds);
    });
    _timeToNextTurnController.addListener(() {
      _clearErrorMessage(_messageErrorTimeToNextTurn);
    });
  }

  void _clearErrorMessage(String? errorMessage) {
    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }

    setState(() {
      if (_nameController.text.isNotEmpty) {
        _messageErrorName = null;
      }
      if (_timeController.text.isNotEmpty) {
        _messageErrorTime = null;
      }
      if (_roundsController.text.isNotEmpty) {
        _messageErrorRounds = null;
      }
      if (_timeToNextTurnController.text.isNotEmpty) {
        _messageErrorTimeToNextTurn = null;
      }
    });
  }

  void _combatRegister() async {
    final nameCombat = _nameController.text.trim();
    final timeCombat = _timeController.text.trim();
    final roundsCombat = _roundsController.text.trim();
    final timeToNextTurnCombat = _timeToNextTurnController.text.trim();

    if (nameCombat.isEmpty ||
        timeCombat.isEmpty ||
        roundsCombat.isEmpty ||
        timeToNextTurnCombat.isEmpty) {
      setState(() {
        _messageErrorName = nameCombat.isEmpty ? 'Campo obrigatório.' : null;
        _messageErrorTime = timeCombat.isEmpty ? 'Campo obrigatório.' : null;
        _messageErrorRounds =
            roundsCombat.isEmpty ? 'Campo obrigatório.' : null;
        _messageErrorTimeToNextTurn =
            timeToNextTurnCombat.isEmpty ? 'Campo obrigatório.' : null;
      });
    } else {
      try {
        print('tentando inserir');
        await _combatsRepository.insertCombat({
          'name': _nameController.text,
          'timeActual': int.parse(_timeController.text),
          'turns': 0,
          'rounds': int.parse(_roundsController.text),
          'timeToNextTurn': int.parse(_timeToNextTurnController.text),
        });
      } catch (e) {
        print('Erro ao atualizar o combate: $e');
      } finally {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
          arguments: 1,
        );
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
          arguments: 1,
        );
        return false; // Impede o comportamento padrão de voltar
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar combate'),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputText(
                    controller: _nameController,
                    errorMessage: _messageErrorName,
                    maxLength: 30,
                    placeholder: "nome do combate",
                    label: "NOME",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InputNumberInt(
                    controller: _timeController,
                    errorMessage: _messageErrorTime,
                    label: "TEMPO ATUAL",
                  ),
                  InputNumberInt(
                      controller: _timeToNextTurnController,
                      errorMessage: _messageErrorTimeToNextTurn,
                      label: "PROXIMA RODADA"),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputNumberInt(
                    controller: _roundsController,
                    errorMessage: _messageErrorRounds,
                    label: "RODADAS",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonFormConfirm(
                    register: () {
                      _combatRegister();
                    },
                    textInButton: 'Cadastrar combate',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
