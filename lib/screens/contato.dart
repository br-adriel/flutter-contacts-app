import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contato.dart';
import 'package:flutter_contacts/repositories/back4app/contatos.dart';
import 'package:flutter_contacts/screens/form_contato.dart';
import 'package:url_launcher/url_launcher.dart';

class ContatoScreen extends StatelessWidget {
  final ContatoModel _contato;

  const ContatoScreen(this._contato, {super.key});

  _enviarSMS(String telefone) {
    String numero = telefone.replaceAll(RegExp(r'\D'), '');
    launchUrl(Uri.parse("sms:$numero"));
  }

  _enviarEmail(String email) {
    launchUrl(Uri.parse("mailto:${email.trim()}"));
  }

  _apagar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Apagar contato?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                ContatosB4ARepository()
                    .remover(_contato.objectId)
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
              ),
              child: const Text("Apagar"),
            ),
          ],
        );
      },
    );
  }

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
                onPressed: () => _apagar(context),
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
                        onPressed: () => _enviarSMS(tel),
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
                    onPressed: () => _enviarEmail(email),
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
