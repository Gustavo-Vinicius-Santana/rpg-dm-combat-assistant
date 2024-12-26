import 'package:flutter/material.dart';

class ListCombat extends StatefulWidget {
  const ListCombat({super.key, required this.personsInCombat});
  final List<Map<String, dynamic>> personsInCombat;

  @override
  State<ListCombat> createState() => _ListCombatState();
}

class _ListCombatState extends State<ListCombat> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.personsInCombat.length,
        itemBuilder: (context, index) {
          final person = widget.personsInCombat[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.person, color: Colors.blue),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "NOME:",
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                            Text(
                              person['name'],
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 40.0,
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "JOGADOR:",
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                            Text(
                              "teste",
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 40.0,
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ARMADURA:",
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                            Text(
                              "10",
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 40.0,
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "PV:",
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                            Text(
                              "10/10",
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.grey),
                          onPressed: () {
                            print('Editar ${person['name']}');
                          },
                        ),
                      ],
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
