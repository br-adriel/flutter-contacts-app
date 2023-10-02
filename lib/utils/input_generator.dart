import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputGenerator {
  final List<TextEditingController> _controllers = [];
  String label;
  int countStart;
  TextInputType inputType;
  List<TextInputFormatter> formatters;
  String? Function(String?)? validator;

  InputGenerator({
    this.label = "",
    this.countStart = 1,
    this.inputType = TextInputType.text,
    this.formatters = const [],
    this.validator,
  });

  adicionarCampo() {
    _controllers.add(TextEditingController(text: ""));
  }

  gerarCampos({required Function afterRemove}) {
    return _controllers.asMap().entries.map((entry) {
      return Row(
        children: [
          Flexible(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: "$label ${entry.key + countStart}",
              ),
              inputFormatters: formatters,
              textInputAction: TextInputAction.next,
              keyboardType: inputType,
              controller: entry.value,
              validator: validator,
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
