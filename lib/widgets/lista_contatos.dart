import 'package:flutter/material.dart';
import 'package:flutter_contacts/widgets/contato_list_tile.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ListaDeContatos extends StatelessWidget {
  final List<String> alfabeto =
      "&abcdefghijklmnopqrstuvwxyz".toUpperCase().split("");

  ListaDeContatos({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: alfabeto.length,
      itemBuilder: (context, index) {
        String letra = alfabeto[index];
        return StickyHeader(
          header: Container(
            width: double.infinity,
            color: Colors.blueGrey[50],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              letra,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: const Column(
            children: [
              ContatoListTile("Fulano", "+55 84 9012345678"),
              ContatoListTile("Fulano", "+55 84 9012345678"),
              ContatoListTile("Fulano", "+55 84 9012345678"),
              ContatoListTile("Fulano", "+55 84 9012345678"),
            ],
          ),
        );
      },
    );
  }
}
