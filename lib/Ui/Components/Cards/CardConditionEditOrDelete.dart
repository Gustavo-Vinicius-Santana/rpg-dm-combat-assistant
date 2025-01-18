import 'package:flutter/material.dart';

class CardConditionEditOrDelete extends StatefulWidget {
  const CardConditionEditOrDelete(
      {super.key, required this.name, required this.description});
  final String name;
  final String description;

  @override
  State<CardConditionEditOrDelete> createState() =>
      _CardConditionEditOrDeleteState();
}

class _CardConditionEditOrDeleteState extends State<CardConditionEditOrDelete> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.name}', style: const TextStyle(fontSize: 20.0)),
                PopupMenuButton<int>(
                  onSelected: (value) {
                    if (value == 1) {
                      print("Opção 1 selecionada");
                    } else if (value == 2) {
                      print("Opção 2 selecionada");
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Editar"),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text("Deletar"),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${widget.description}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
