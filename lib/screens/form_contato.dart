import 'package:flutter/material.dart';
import 'package:flutter_contacts/utils/input_generator.dart';
import 'package:flutter_contacts/widgets/imagem_perfil_input.dart';
import 'package:image_picker/image_picker.dart';

class FormContatoScreen extends StatefulWidget {
  final bool atualizar;

  const FormContatoScreen({super.key, this.atualizar = false});

  @override
  State<FormContatoScreen> createState() => _FormContatoScreenState();
}

class _FormContatoScreenState extends State<FormContatoScreen> {
  XFile? _imagem;

  final TextEditingController _nome = TextEditingController(text: "");
  final TextEditingController _sobrenome = TextEditingController(text: "");
  final TextEditingController _telefonePadrao = TextEditingController(text: "");
  final TextEditingController _emailPadrao = TextEditingController(text: "");
  final InputGenerator _telefones = InputGenerator(
    countStart: 2,
    inputType: TextInputType.phone,
    label: "Telefone",
  );
  final InputGenerator _emails = InputGenerator(
    countStart: 2,
    inputType: TextInputType.emailAddress,
    label: "Email",
  );

  _adicionarCampoTelefone() {
    _telefones.adicionarCampo();
    setState(() {});
  }

  _adicionarCampoEmail() {
    _emails.adicionarCampo();
    setState(() {});
  }

  _aposRemoverCampo() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.atualizar ? "Atualizar" : "Adicionar"} contato"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Salvar",
        child: const Icon(Icons.save),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ImagemDePerfilInput(_imagem),
          TextField(
            decoration: const InputDecoration(labelText: "Nome"),
            textInputAction: TextInputAction.next,
            controller: _nome,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Sobrenome"),
            textInputAction: TextInputAction.next,
            controller: _sobrenome,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: TextField(
                  decoration: const InputDecoration(labelText: "Telefone 1"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  controller: _telefonePadrao,
                ),
              ),
              IconButton(
                onPressed: _adicionarCampoTelefone,
                icon: const Icon(Icons.add, color: Colors.blue),
                tooltip: "Adicionar outro",
              )
            ],
          ),
          ..._telefones.gerarCampos(afterRemove: _aposRemoverCampo),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: TextField(
                  decoration: const InputDecoration(labelText: "Email 1"),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailPadrao,
                ),
              ),
              IconButton(
                onPressed: _adicionarCampoEmail,
                icon: const Icon(Icons.add, color: Colors.blue),
                tooltip: "Adicionar outro",
              )
            ],
          ),
          ..._emails.gerarCampos(afterRemove: _aposRemoverCampo),
          const SizedBox(height: 64)
        ],
      ),
    );
  }
}
