import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/conditions_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monster_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAction.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListConditionsSelectOrDelete.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Loadings/Loading.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Modals/ModalCreateCondition.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Modals/ModalEditCondition.dart';

class ManagePersonConditionScreen extends StatefulWidget {
  const ManagePersonConditionScreen({super.key});

  @override
  State<ManagePersonConditionScreen> createState() =>
      _ManagePersonConditionScreenState();
}

class _ManagePersonConditionScreenState
    extends State<ManagePersonConditionScreen> {
  final MonsterInCombatRepository monster_repository =
      MonsterInCombatRepository();
  final CharacterInCombatRepository character_repository =
      CharacterInCombatRepository();

  final ConditionsRepository conditions_repository = ConditionsRepository();

  List<Map<String, dynamic>> _mapConditions = [];
  List<int> idsConditionsSelectedToAdd = [];
  List<String> conditionsSelectedToAdd = [];

  List? listPersonConditions;

  int? id;
  String? type;

  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is Map<String, dynamic>) {
      id = arguments['id'];
      type = arguments['type'];

      _initializeData();
    }
  }

  Future<void> _initializeData() async {
    setState(() {
      isLoading = true; // Inicia o carregamento
    });

    // Aguardar o carregamento das condições e das condições do personagem
    await Future.wait([
      _loadConditions(),
      _loadPersonConditions(id!),
    ]);

    // Após o carregamento, configurar as condições selecionadas
    if (listPersonConditions != null) {
      for (final condition in listPersonConditions!) {
        await _setConditionsPersonSetlected(condition);
      }
    }

    setState(() {
      isLoading = false; // Finaliza o carregamento
    });
  }

  Future<void> _setConditionsPersonSetlected(String? conditionToCompare) async {
    if (conditionToCompare == null || conditionToCompare.isEmpty) return;

    try {
      final allConditions = await conditions_repository.getAllConditions();

      for (final condition in allConditions) {
        if (condition['name_id'] == conditionToCompare &&
            !idsConditionsSelectedToAdd.contains(condition['id'])) {
          setState(() {
            idsConditionsSelectedToAdd.add(condition['id']);
          });
        }
      }
    } catch (e) {
      print('Erro ao definir condição selecionada: $e');
    }
  }

  Future<void> _loadConditions() async {
    final dataCondition = await conditions_repository.getAllConditions();
    setState(() {
      _mapConditions = dataCondition;
    });
  }

  Future<void> _loadPersonConditions(int id) async {
    try {
      print('Carregando todas as condições');

      List<Map<String, dynamic>>? dataConditionPerson;

      if (type == 'character') {
        dataConditionPerson =
            await character_repository.getCharacterConditions(id);
      } else if (type == 'monster') {
        dataConditionPerson = await monster_repository.getMonsterConditions(id);
      }

      if (dataConditionPerson != null && dataConditionPerson.isNotEmpty) {
        final conditions = [
          dataConditionPerson[0]['condition_1'],
          dataConditionPerson[0]['condition_2'],
          dataConditionPerson[0]['condition_3'],
          dataConditionPerson[0]['condition_4'],
        ].where((condition) => condition != null).toList();

        setState(() {
          listPersonConditions = conditions.cast<String>();
        });

        for (final condition in listPersonConditions!) {
          _setConditionsPersonSetlected(condition);
        }
      } else {
        print('Nenhuma condição encontrada para o ID fornecido.');
      }
    } catch (e) {
      print('Erro ao carregar condições da pessoa: $e');
    }
  }

  void teste() {
    print('condições selecionadas: $idsConditionsSelectedToAdd');
  }

  void _manageConditions(int id) async {
    print('Editar teste');

    print('Condições selecionadas: $idsConditionsSelectedToAdd');

    try {
      for (final idCondition in idsConditionsSelectedToAdd) {
        final condition =
            await conditions_repository.getConditionById(idCondition);

        conditionsSelectedToAdd.add(condition[0]['name_id']);
      }

      final condition_1 = conditionsSelectedToAdd.length > 0
          ? conditionsSelectedToAdd[0]
          : null;
      final condition_2 = conditionsSelectedToAdd.length > 1
          ? conditionsSelectedToAdd[1]
          : null;
      final condition_3 = conditionsSelectedToAdd.length > 2
          ? conditionsSelectedToAdd[2]
          : null;
      final condition_4 = conditionsSelectedToAdd.length > 3
          ? conditionsSelectedToAdd[3]
          : null;

      Map<String, dynamic> personEdited = {
        'condition_1': condition_1,
        'condition_2': condition_2,
        'condition_3': condition_3,
        'condition_4': condition_4,
      };

      if (type == 'character') {
        await character_repository.updateCharacterInCombat(id, personEdited);
      }

      if (type == 'monster') {
        await monster_repository.updateMonsterInCombat(id, personEdited);
      }

      Navigator.pushNamed(
        context,
        '/combatScreen',
        arguments: {
          'id': id,
          'openModal': [id, type],
        },
      );
    } catch (e) {
      print('Erro ao editar o personagem: $e');
    }
  }

  void _openModalCreateCondition() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalCreateCondition(
          personId: id!,
        );
      },
    );
  }

  void _openModalEditCondition(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalEditCondition(
          idCondition: id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
          context,
          '/combatScreen',
          arguments: {
            'id': id,
            'openModal': [id, type],
          },
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gerenciar Condições'),
        ),
        body: isLoading
            ? const Center(
                child: Loading(),
              )
            : Center(
                child: Column(
                  children: [
                    ButtonAction(
                      onPressed: () {
                        print('Adicionar condição');

                        _manageConditions(id!);
                      },
                      textInButton: 'Gerenciar condições',
                      fontSize: 18,
                      width: 375,
                      height: 50,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 375,
                      height: 500,
                      child: ListConditionsSelectOrDelete(
                        conditionsList: _mapConditions,
                        idsSelected: idsConditionsSelectedToAdd,
                        onTapOpenModal: _openModalEditCondition,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ButtonAction(
                      onPressed: () {
                        print('criar condição');

                        _openModalCreateCondition();
                      },
                      textInButton: 'Criar condição',
                      fontSize: 18,
                      width: 200,
                      height: 50,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
