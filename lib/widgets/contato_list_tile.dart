import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contato.dart';
import 'package:flutter_contacts/screens/contato.dart';

class ContatoListTile extends StatelessWidget {
  final ContatoModel _contato;
  final void Function()? onLeave;

  const ContatoListTile(this._contato, {super.key, this.onLeave});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ContatoScreen(_contato);
          },
        )).then((value) {
          if (onLeave != null) {
            onLeave!();
          }
        });
      },
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
