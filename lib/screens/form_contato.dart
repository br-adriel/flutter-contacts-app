import 'package:flutter/material.dart';
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
  final List<TextEditingController> _telefones = [];
  final List<TextEditingController> _emails = [];

  _adicionarCampo(List<TextEditingController> controllerList) {
    controllerList.add(TextEditingController(text: ""));
    setState(() {});
  }

  _adicionarCampoTelefone() {
    _adicionarCampo(_telefones);
  }

  _adicionarCampoEmail() {
    _adicionarCampo(_emails);
  }

  _removerCampo(List<TextEditingController> controllerList, int index) {
    controllerList.removeAt(index);
    setState(() {});
  }

  _gerarCampos(List<TextEditingController> controllers, String label,
      TextInputType tipoInput) {
    return controllers.asMap().entries.map((entry) {
      return Row(
        children: [
          Flexible(
            child: TextField(
              decoration: InputDecoration(labelText: "$label ${entry.key + 2}"),
              textInputAction: TextInputAction.next,
              keyboardType: tipoInput,
              controller: entry.value,
            ),
          ),
          IconButton(
            onPressed: () => _removerCampo(controllers, entry.key),
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          )
        ],
      );
    }).toList();
  }

  _gerarEmailsExtra() {
    return _gerarCampos(_emails, "Email", TextInputType.emailAddress);
  }

  _gerarTelefonesExtra() {
    return _gerarCampos(_telefones, "Telefone", TextInputType.phone);
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
          ..._gerarTelefonesExtra(),
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
          ..._gerarEmailsExtra(),
        ],
      ),
    );
  }
}
