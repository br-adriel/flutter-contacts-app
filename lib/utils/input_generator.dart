import 'package:flutter/material.dart';

class InputGenerator {
  final List<TextEditingController> _controllers = [];
  String label;
  int countStart;
  TextInputType inputType;

  InputGenerator({
    this.label = "",
    this.countStart = 1,
    this.inputType = TextInputType.text,
  });

  adicionarCampo() {
    _controllers.add(TextEditingController(text: ""));
  }

  gerarCampos({required Function afterRemove}) {
    return _controllers.asMap().entries.map((entry) {
      return Row(
        children: [
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                labelText: "$label ${entry.key + countStart}",
              ),
              textInputAction: TextInputAction.next,
              keyboardType: inputType,
              controller: entry.value,
            ),
          ),
          IconButton(
            onPressed: () {
              _controllers.removeAt(entry.key);
              afterRemove();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          )
        ],
      );
    }).toList();
  }

  get controllers => _controllers;
}
