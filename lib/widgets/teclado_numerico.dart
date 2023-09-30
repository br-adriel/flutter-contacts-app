import 'package:flutter/material.dart';

class TecladoNumerico extends StatefulWidget {
  const TecladoNumerico({super.key});

  @override
  State<TecladoNumerico> createState() => _TecladoNumericoState();
}

class _TecladoNumericoState extends State<TecladoNumerico> {
  final List<List<String>> _teclas = [
    ["1", "2", "3"],
    ["4", "5", "6"],
    ["7", "8", "9"],
    ["*", "0", "#"],
  ];
  String _conteudo = "";

  _pressionarTecla(String valor) {
    _conteudo += valor;
    setState(() {});
  }

  _apagar() {
    if (_conteudo.isNotEmpty) {
      _conteudo = _conteudo.substring(0, _conteudo.length - 1);
      setState(() {});
    }
  }

  Widget _teclaStringToButton(String tecla) {
    return Expanded(
      child: TextButton(
        onPressed: () => _pressionarTecla(tecla),
        child: Text(
          tecla,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }

  Widget _teclasListToButton(List<String> teclas) {
    return Expanded(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: teclas.map(_teclaStringToButton).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    _conteudo,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_conteudo.isNotEmpty)
                  InkWell(
                    onLongPress: () {
                      _conteudo = "";
                      setState(() {});
                    },
                    child: IconButton(
                      onPressed: _apagar,
                      icon: const Icon(Icons.backspace),
                      color: Colors.blue,
                    ),
                  )
              ],
            ),
          ),
        ),
        ..._teclas.map(_teclasListToButton).toList(),
        Expanded(child: Container())
      ],
    );
  }
}
