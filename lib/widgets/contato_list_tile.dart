import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contato.dart';

class ContatoListTile extends StatelessWidget {
  final ContatoModel _contato;

  const ContatoListTile(this._contato, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          foregroundImage: _contato.imagem.isEmpty
              ? const AssetImage("assets/img/profile.jpg")
              : FileImage(File(_contato.imagem)) as ImageProvider,
        ),
        title: Text("${_contato.nome} ${_contato.sobrenome}"),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.phone),
        ),
        subtitle:
            Text(_contato.telefones.isNotEmpty ? _contato.telefones[0] : ""),
      ),
    );
  }
}
