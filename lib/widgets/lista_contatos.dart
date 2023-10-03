import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contato.dart';
import 'package:flutter_contacts/widgets/contato_list_tile.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ListaDeContatos extends StatelessWidget {
  final List<String> _alfabeto =
      "&abcdefghijklmnopqrstuvwxyz".toUpperCase().split("");
  late final List<ContatoModel> _contatos;
  final Map<String, List<ContatoModel>> _contatosOrganizados = {};

  ListaDeContatos(this._contatos, {super.key}) {
    for (int i = _alfabeto.length - 1; i > 0; i--) {
      List<ContatoModel> contatosNessaLetra = _contatos
          .where(
              (contato) => contato.nome.toUpperCase().startsWith(_alfabeto[i]))
          .toList();
      if (contatosNessaLetra.isNotEmpty) {
        _contatosOrganizados[_alfabeto[i]] = contatosNessaLetra;
        _contatos.removeWhere(
            (contato) => contato.nome.toUpperCase().startsWith(_alfabeto[i]));
      }
    }
    if (_contatos.isNotEmpty) {
      _contatosOrganizados[_alfabeto[0]] = _contatos.map((e) => e).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> letrasComContato = _contatosOrganizados.keys.toList();
    letrasComContato.sort((a, b) => a.compareTo(b));
    return letrasComContato.isEmpty
        ? Center(
            child: Padding(
                padding: EdgeInsets.all(16), child: Text("Nenhum contato")),
          )
        : ListView.builder(
            itemCount: _contatosOrganizados.keys.length,
            itemBuilder: (context, index) {
              String letra = letrasComContato.elementAt(index);
              return StickyHeader(
                header: Container(
                  width: double.infinity,
                  color: Colors.blueGrey[50],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    letra,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                content: Column(
                  children: _contatosOrganizados[letra]!.map((contato) {
                    return ContatoListTile(contato);
                  }).toList(),
                ),
              );
            },
          );
  }
}
