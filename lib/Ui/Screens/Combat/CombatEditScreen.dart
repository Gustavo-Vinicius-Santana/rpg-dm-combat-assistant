import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/combats_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonFormConfirm.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputNumberInt.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputText.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Loadings/Loading.dart';

class CombatEditScreen extends StatefulWidget {
  const CombatEditScreen({super.key});

  @override
  State<CombatEditScreen> createState() => _CombatEditScreenState();
}

class _CombatEditScreenState extends State<CombatEditScreen> {
  CombatsRepository _combatsRepository = CombatsRepository();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _turnsController = TextEditingController();
  final TextEditingController _roundsController = TextEditingController();
  final TextEditingController _timeToNextTurnController =
      TextEditingController();

  String? _messageErrorName;
  String? _messageErrorTime;
  String? _messageErrorTurns;
  String? _messageErrorRounds;
  String? _messageErrorTimeToNextTurn;

  int? id;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is int) {
      id = arguments;
      _loadCombat(id!);
    } else {
      throw Exception("ID não fornecido ou inválido");
    }
  }

  void _loadCombat(int id) async {
    try {
      final combat = await _combatsRepository.getCombatById(id);
      print('combat: $combat');
      setState(() {
        _nameController.text = combat[0]['name'];
        _timeController.text = combat[0]['timeActual'].toString();
        _turnsController.text = combat[0]['turns'].toString();
        _roundsController.text = combat[0]['rounds'].toString();
        _timeToNextTurnController.text = combat[0]['timeToNextTurn'].toString();
      });
    } catch (e) {
      print('Erro ao carregar o combate: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void initState() {
    super.initState();

    _nameController.addListener(() {
      _clearErrorMessage(_messageErrorName);
    });
    _timeController.addListener(() {
      _clearErrorMessage(_messageErrorTime);
    });
    _turnsController.addListener(() {
      _clearErrorMessage(_messageErrorTurns);
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
      if (_turnsController.text.isNotEmpty) {
        _messageErrorTurns = null;
      }
      if (_roundsController.text.isNotEmpty) {
        _messageErrorRounds = null;
      }
      if (_timeToNextTurnController.text.isNotEmpty) {
        _messageErrorTimeToNextTurn = null;
      }
    });
  }

  void _updateCombat(int? id) async {
    final nameCombat = _nameController.text.trim();
    final timeCombat = _timeController.text.trim();
    final turnsCombat = _turnsController.text.trim();
    final roundsCombat = _roundsController.text.trim();
    final timeToNextTurnCombat = _timeToNextTurnController.text.trim();

    if (nameCombat.isEmpty ||
        timeCombat.isEmpty ||
        turnsCombat.isEmpty ||
        roundsCombat.isEmpty ||
        timeToNextTurnCombat.isEmpty) {
      setState(() {
        _messageErrorName = nameCombat.isEmpty ? 'Campo obrigatório.' : null;
        _messageErrorTime = timeCombat.isEmpty ? 'Campo obrigatório.' : null;
        _messageErrorTurns = turnsCombat.isEmpty ? 'Campo obrigatório.' : null;
        _messageErrorRounds =
            roundsCombat.isEmpty ? 'Campo obrigatório.' : null;
        _messageErrorTimeToNextTurn =
            timeToNextTurnCombat.isEmpty ? 'Campo obrigatório.' : null;
      });
    } else {
      try {
        await _combatsRepository.updateCombat(id!, {
          'name': _nameController.text,
          'timeActual': int.parse(_timeController.text),
          'turns': int.parse(_turnsController.text),
          'rounds': int.parse(_roundsController.text),
          'timeToNextTurn': int.parse(_timeToNextTurnController.text),
        });
        Navigator.pushNamed(context, '/combatScreen', arguments: id);
      } catch (e) {
        print('Erro ao atualizar o combate: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(
          context,
          '/combatScreen',
          arguments: id,
        );
        return false; // Impede o comportamento padrão de voltar
      },
      child: _isLoading
          ? const Center(
              child: Loading(),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text('Editar Combate'),
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
                            _updateCombat(id);
                          },
                          textInButton: 'Atualizar combate',
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
