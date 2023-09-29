import 'package:flutter/material.dart';
import 'package:flutter_contacts/widgets/lista_contatos.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  int _paginaAtual = 1;
  String _titulo = "Contatos";

  _atualizarConteudo(int value) {
    if (mounted) {
      _paginaAtual = value;
      _titulo = value == 0 ? 'Telefone' : 'Contatos';
      _pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titulo)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
        children: [Container(), ListaDeContatos()],
      ),
    );
  }
}
