import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/models/contato.dart';
import 'package:flutter_contacts/repositories/back4app/contatos.dart';
import 'package:flutter_contacts/utils/input_generator.dart';
import 'package:flutter_contacts/widgets/imagem_perfil_input.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:validatorless/validatorless.dart';

class FormContatoScreen extends StatefulWidget {
  final bool atualizar;

  const FormContatoScreen({super.key, this.atualizar = false});

  @override
  State<FormContatoScreen> createState() => _FormContatoScreenState();
}

class _FormContatoScreenState extends State<FormContatoScreen> {
  XFile? _imagem;
  final ImagePicker _imagePicker = ImagePicker();

  final _contatosB4ARepository = ContatosB4ARepository();

  final _nome = TextEditingController(text: "");
  final _sobrenome = TextEditingController(text: "");
  final _telefonePadrao = TextEditingController(text: "");
  final _emailPadrao = TextEditingController(text: "");
  final _telefones = InputGenerator(
    countStart: 2,
    inputType: TextInputType.phone,
    label: "Telefone",
    formatters: [
      FilteringTextInputFormatter.digitsOnly,
      TelefoneInputFormatter()
    ],
  );
  final _emails = InputGenerator(
    countStart: 2,
    inputType: TextInputType.emailAddress,
    label: "Email",
    validator: Validatorless.email("Digite um email válido"),
  );

  bool _loading = false;

  _abrirSeletorDeFonte() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              onTap: () {
                _selecionarImagem(ImageSource.camera);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.camera_alt),
              title: const Text("Câmera"),
            ),
            ListTile(
              onTap: () {
                _selecionarImagem(ImageSource.gallery);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.photo),
              title: const Text("Galeria"),
            ),
            ListTile(
              onTap: () {
                _imagem = null;
                setState(() {});
                Navigator.pop(context);
              },
              leading: const Icon(Icons.image_not_supported),
              title: const Text("Remover imagem"),
            ),
          ],
        );
      },
    );
  }

  void _selecionarImagem(ImageSource fonte) async {
    _imagem = await _imagePicker.pickImage(source: fonte);
    if (_imagem != null) {
      String path = (await getApplicationDocumentsDirectory()).path;
      String nome = p.basename(_imagem!.path);
      await _imagem!.saveTo("$path/$nome");
      if (fonte == ImageSource.camera) {
        await GallerySaver.saveImage(_imagem!.path);
      }
      setState(() {});
    }
  }

  ImageProvider _imagemSelecionada() {
    if (_imagem == null) {
      return const AssetImage("assets/img/profile.jpg");
    }
    return FileImage(File(_imagem!.path));
  }

  _salvar() async {
    List<String> emails = _emailPadrao.text.isEmpty ? [] : [_emailPadrao.text];
    emails.addAll(_emails.controllersValues);

    List<String> telefones =
        _telefonePadrao.text.isEmpty ? [] : [_telefonePadrao.text];
    telefones.addAll(_telefones.controllersValues);

    _nome.text = _nome.text.trim();
    _sobrenome.text = _nome.text.trim();
    setState(() {});
    if (_nome.text.isEmpty) return;

    var contato = ContatoModel(
      nome: _nome.text,
      emails: emails,
      imagem: _imagem == null ? "" : _imagem!.path,
      sobrenome: _sobrenome.text,
      telefones: telefones,
    );
    _loading = true;
    setState(() {});
    await _contatosB4ARepository.adicionar(contato);
    _loading = false;
    setState(() {});
    _mostrarDialogo();
  }

  _mostrarDialogo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Contato salvo"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

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
      floatingActionButton: _loading
          ? null
          : FloatingActionButton(
              onPressed: _salvar,
              tooltip: "Salvar",
              child: const Icon(Icons.save),
            ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ImagemDePerfilInput(
                  onImageSelect: _abrirSeletorDeFonte,
                  selectedImage: _imagemSelecionada,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: "Nome"),
                  textInputAction: TextInputAction.next,
                  controller: _nome,
                  validator: Validatorless.multiple([
                    Validatorless.required("Preencha o campo nome"),
                    Validatorless.min(
                      2,
                      "O campo deve ter no mínimo 2 caracteres",
                    ),
                  ]),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: "Sobrenome"),
                  textInputAction: TextInputAction.next,
                  controller: _sobrenome,
                  validator: Validatorless.min(
                    2,
                    "O campo deve ter no mínimo 2 caracteres",
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                        decoration:
                            const InputDecoration(labelText: "Telefone 1"),
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
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(labelText: "Email 1"),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailPadrao,
                        validator:
                            Validatorless.email("Digite um email válido"),
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
