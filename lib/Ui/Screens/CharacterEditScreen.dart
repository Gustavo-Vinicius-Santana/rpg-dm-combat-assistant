import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonFormConfirm.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputNumberInt.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Input/InputText.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Loadings/Loading.dart';

class CharacterEditScreen extends StatefulWidget {
  const CharacterEditScreen({super.key});

  @override
  State<CharacterEditScreen> createState() => _CharacterEditScreenState();
}

class _CharacterEditScreenState extends State<CharacterEditScreen> {
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

  int? id;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Obtendo os argumentos da rota
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is int) {
      id = arguments; // Armazena o ID recebido
      _loadCharacter(id!); // Carrega o personagem
    } else {
      // Caso os argumentos não sejam válidos, lida com o erro
      throw Exception("ID não fornecido ou inválido");
    }
  }

  void _loadCharacter(int id) async {
    try {
      final character = await _characterRepository.getCharacterById(id);
      setState(() {
        _namePlayerController.text = character[0]['player'];
        _nameCharacterController.text = character[0]['name'];
        _armorController.text = character[0]['armor'].toString();
        _maxHealthController.text = character[0]['lifeMax'].toString();
        _minHealthController.text = character[0]['lifeActual'].toString();
      });
    } catch (e) {
      print('Erro ao carregar o personagem: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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

  void _registerCharacter(int id) async {
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
        await _characterRepository.updateCharacter(id, character);
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
          arguments: 0,
        );
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar personagem'),
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
                      register: () {
                        _registerCharacter(id!);
                      },
                      textInButton: 'EDITAR',
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
