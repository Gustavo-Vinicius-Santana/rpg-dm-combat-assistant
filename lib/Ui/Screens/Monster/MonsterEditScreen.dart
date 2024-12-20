import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monsters_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonFormConfirm.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputNumberInt.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputText.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Loadings/Loading.dart';

class MonsterEditScreen extends StatefulWidget {
  const MonsterEditScreen({super.key});

  @override
  State<MonsterEditScreen> createState() => _MonsterEditScreenState();
}

class _MonsterEditScreenState extends State<MonsterEditScreen> {
  final MonstersRepository _monsterRepository = MonstersRepository();
  final TextEditingController _nameMonsterController = TextEditingController();
  final TextEditingController _armorController = TextEditingController();
  final TextEditingController _maxHealthController = TextEditingController();
  final TextEditingController _minHealthController = TextEditingController();

  String? _messageErrorNameMonster;
  String? _messageErrorArmor;
  String? _messageErrorMaxHealth;
  String? _messageErrorMinHealth;

  int? id;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Obtendo os argumentos da rota
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is int) {
      id = arguments; // Armazena o ID recebido
      _loadMonster(id!); // Carrega o personagem
    } else {
      // Caso os argumentos não sejam válidos, lida com o erro
      throw Exception("ID não fornecido ou inválido");
    }
  }

  void _loadMonster(int id) async {
    try {
      final monster = await _monsterRepository.getMonsterById(id);
      setState(() {
        _nameMonsterController.text = monster[0]['name'];
        _armorController.text = monster[0]['armor'].toString();
        _maxHealthController.text = monster[0]['lifeMax'].toString();
        _minHealthController.text = monster[0]['lifeActual'].toString();
      });
    } catch (e) {
      print('Erro ao carregar o personagem: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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

  void _editMonster() async {
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
        await _monsterRepository.updateMonster(id!, monster);

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
        return false; // Impede o comportamento padrão de voltar
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar monstro'),
        ),
        body: _isLoading
            ? const Center(
                child: Loading(),
              )
            : Center(
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
                        register: _editMonster,
                        textInButton: 'EDITAR',
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
