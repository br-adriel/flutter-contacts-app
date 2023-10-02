import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputGenerator {
  final List<TextEditingController> _controllers = [];
  String label;
  int countStart;
  TextInputType inputType;
  List<TextInputFormatter> formatters;

  InputGenerator(
      {this.label = "",
      this.countStart = 1,
      this.inputType = TextInputType.text,
      this.formatters = const []});

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
              inputFormatters: formatters,
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

  List<TextEditingController> get controllers => _controllers;

  List<String> get controllersValues =>
      _controllers.where((c) => c.text.isNotEmpty).map((c) => c.text).toList();
}
