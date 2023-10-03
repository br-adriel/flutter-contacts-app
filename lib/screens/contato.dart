import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contato.dart';
import 'package:flutter_contacts/screens/form_contato.dart';

class ContatoScreen extends StatelessWidget {
  final ContatoModel _contato;

  const ContatoScreen(this._contato, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return FormContatoScreen(contatoInicial: _contato);
                  }),
                ),
                icon: const Icon(Icons.edit),
                tooltip: "Editar",
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                tooltip: "Apagar",
              )
            ],
            expandedHeight: MediaQuery.of(context).size.width,
            title: Text(_contato.nomeCompleto),
            flexibleSpace: FlexibleSpaceBar(
              background: _contato.imagem.isEmpty
                  ? Image.asset(
                      "assets/img/profile.jpg",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                    )
                  : Image.file(
                      File(_contato.imagem),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                    ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _contato.telefones.isNotEmpty
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                      child: Text(
                        "Telefones",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : Container(),
              ..._contato.telefones.map((tel) {
                return ListTile(
                  title: Text(tel),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () {},
                        tooltip: "Ligar",
                      ),
                      IconButton(
                        icon: const Icon(Icons.message),
                        onPressed: () {},
                        tooltip: "Enviar SMS",
                      ),
                    ],
                  ),
                );
              }).toList(),
              _contato.emails.isNotEmpty
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                      child: Text(
                        "Emails",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : Container(),
              ..._contato.emails.map((email) {
                return ListTile(
                  title: Text(email),
                  trailing: IconButton(
                    icon: const Icon(Icons.email),
                    onPressed: () {},
                    tooltip: "Escrever email",
                  ),
                );
              }).toList(),
            ]),
          ),
        ],
      ),
    );
  }
}
