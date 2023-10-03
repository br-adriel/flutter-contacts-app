import 'package:flutter/material.dart';

class ImagemDePerfilInput extends StatefulWidget {
  final ImageProvider Function() selectedImage;
  final void Function() onImageSelect;

  const ImagemDePerfilInput(
      {super.key, required this.selectedImage, required this.onImageSelect});

  @override
  State<ImagemDePerfilInput> createState() => _ImagemDePerfilInputState();
}

class _ImagemDePerfilInputState extends State<ImagemDePerfilInput> {
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
                foregroundImage: widget.selectedImage(),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: widget.onImageSelect,
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
