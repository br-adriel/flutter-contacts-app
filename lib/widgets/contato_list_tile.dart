import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contato.dart';
import 'package:flutter_contacts/screens/contato.dart';
import 'package:flutter_contacts/utils/contact_actions.dart';

class ContatoListTile extends StatelessWidget {
  final ContatoModel _contato;

  const ContatoListTile(this._contato, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ContatoScreen(_contato);
          },
        ));
      },
      child: ListTile(
        leading: CircleAvatar(
          foregroundImage: _contato.imagem.isEmpty
              ? const AssetImage("assets/img/profile.jpg")
              : FileImage(File(_contato.imagem)) as ImageProvider,
        ),
        title: Text("${_contato.nome} ${_contato.sobrenome}"),
        trailing: _contato.telefones.isNotEmpty
            ? IconButton(
                onPressed: () {
                  ContactAction.telefonar(_contato.telefones[0]);
                },
                icon: const Icon(Icons.phone),
              )
            : null,
        subtitle:
            Text(_contato.telefones.isNotEmpty ? _contato.telefones[0] : ""),
      ),
    );
  }
}
