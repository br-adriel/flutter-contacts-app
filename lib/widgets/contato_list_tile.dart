import 'package:flutter/material.dart';

class ContatoListTile extends StatelessWidget {
  final String nome;
  final String numero;

  const ContatoListTile(this.nome, this.numero, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const CircleAvatar(),
        title: Text(nome),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.phone),
        ),
        subtitle: Text(numero),
      ),
    );
  }
}
