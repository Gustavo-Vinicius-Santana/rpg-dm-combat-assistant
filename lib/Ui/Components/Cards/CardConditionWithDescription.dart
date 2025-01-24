import 'package:flutter/material.dart';

class CardConditionWhithDescription extends StatefulWidget {
  const CardConditionWhithDescription(
      {super.key,
      required this.name,
      required this.description,
      required this.type,
      required this.selectedIds,
      required this.id,
      required this.onTapOpenModalEdit});
  final int id;
  final String name;
  final String description;
  final String type;

  final List<int> selectedIds;

  final Function onTapOpenModalEdit;

  @override
  State<CardConditionWhithDescription> createState() =>
      _CardConditionWhithDescriptionState();
}

class _CardConditionWhithDescriptionState
    extends State<CardConditionWhithDescription> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.selectedIds.contains(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      child: InkWell(
        onTap: () {
          widget.onTapOpenModalEdit(widget.id);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.name}',
                      style: const TextStyle(fontSize: 20.0)),
                  if (widget.type == 'delete')
                    const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    )
                  else if (widget.type == 'select')
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                          if (isChecked) {
                            widget.selectedIds.add(widget.id);
                          } else {
                            widget.selectedIds.remove(widget.id);
                          }
                        });
                      },
                    )
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
      ),
    );
  }
}
