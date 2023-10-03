import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contato.dart';
import 'package:flutter_contacts/repositories/back4app/contatos.dart';
import 'package:flutter_contacts/screens/form_contato.dart';
import 'package:flutter_contacts/widgets/lista_contatos.dart';
import 'package:flutter_contacts/widgets/teclado_numerico.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  int _paginaAtual = 1;
  String _titulo = "Contatos";
  final ContatosB4ARepository _repository = ContatosB4ARepository();
  late List<ContatoModel> _contatos;
  bool _loading = false;

  _carregarContatos() async {
    _loading = true;
    setState(() {});
    _contatos = await _repository.listar();
    _loading = false;
    setState(() {});
  }

  _tapFloatingButton() {
    if (_paginaAtual == 0) {
      return;
    }
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const FormContatoScreen();
      },
    )).then((value) => _carregarContatos());
  }

  _atualizarConteudo(int value) {
    if (mounted) {
      _paginaAtual = value;
      _titulo = value == 0 ? 'Telefone' : 'Contatos';
      if (value == 1 && _contatos.isEmpty) _carregarContatos();
      _pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titulo)),
      floatingActionButton: FloatingActionButton(
        onPressed: _tapFloatingButton,
        tooltip: _paginaAtual == 0 ? "Telefonar" : "Adicionar contato",
        child: Icon(_paginaAtual == 0 ? Icons.phone : Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaAtual,
        onTap: _atualizarConteudo,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dialpad), label: "Telefone"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Contatos"),
        ],
      ),
      body: PageView(
        onPageChanged: _atualizarConteudo,
        controller: _pageController,
        children: [
          const TecladoNumerico(),
          _loading
              ? const Center(child: CircularProgressIndicator())
              : ListaDeContatos(_contatos, onLeave: _carregarContatos)
        ],
      ),
    );
  }
}
