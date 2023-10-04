import 'package:url_launcher/url_launcher.dart';

class ContactAction {
  static enviarSMS(String telefone) {
    String numero = telefone.replaceAll(RegExp(r'\D'), '');
    launchUrl(Uri.parse("sms:$numero"));
  }

  static telefonar(String telefone) {
    String numero = telefone.replaceAll(RegExp(r'\D'), '');
    launchUrl(Uri.parse("tel:$numero"));
  }

  static enviarEmail(String email) {
    launchUrl(Uri.parse("mailto:${email.trim()}"));
  }
}
