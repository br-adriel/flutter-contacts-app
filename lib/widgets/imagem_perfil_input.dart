import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagemDePerfilInput extends StatefulWidget {
  XFile? _imagem;

  ImagemDePerfilInput(this._imagem, {super.key});

  @override
  State<ImagemDePerfilInput> createState() => _ImagemDePerfilInputState();
}

class _ImagemDePerfilInputState extends State<ImagemDePerfilInput> {
  final ImagePicker _imagePicker = ImagePicker();

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
              leading: const Icon(Icons.camera),
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
          ],
        );
      },
    );
  }

  _selecionarImagem(ImageSource fonte) async {
    widget._imagem = await _imagePicker.pickImage(source: fonte);
    if (widget._imagem != null) {}
  }

  ImageProvider _imagemSelecionada() {
    if (widget._imagem == null) {
      return const AssetImage("assets/img/profile.jpg");
    }
    return const AssetImage("assets/img/profile.jpg");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Material(
              elevation: 1,
              borderRadius: const BorderRadius.all(Radius.circular(500)),
              child: CircleAvatar(
                foregroundImage: _imagemSelecionada(),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: _abrirSeletorDeFonte,
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder()),
                  padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
