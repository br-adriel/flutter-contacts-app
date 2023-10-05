import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialButtonLink extends StatelessWidget {
  final String _imagem;
  final String _link;
  final String? title;

  const SocialButtonLink(this._imagem, this._link, {super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: title,
      onPressed: () async {
        Uri url = Uri.parse(_link);
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
      },
      icon: SvgPicture.asset(
        _imagem,
        width: 32,
        height: 32,
      ),
    );
  }
}
