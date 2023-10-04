import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contato.dart';
import 'package:flutter_contacts/repositories/back4app/contatos.dart';
import 'package:flutter_contacts/screens/form_contato.dart';
import 'package:flutter_contacts/widgets/contato_list_tile.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ContatosB4ARepository _repository = ContatosB4ARepository();
  late List<ContatoModel> _contatos;
  bool _loading = false;
  final List<String> _alfabeto =
      "&abcdefghijklmnopqrstuvwxyz".toUpperCase().split("");
  final Map<String, List<ContatoModel>> _contatosOrganizados = {};

  _carregarContatos() async {
    _loading = true;
    setState(() {});
    _contatos = await _repository.listar();

    for (int i = _alfabeto.length - 1; i > 0; i--) {
      List<ContatoModel> contatosNessaLetra = _contatos
          .where(
              (contato) => contato.nome.toUpperCase().startsWith(_alfabeto[i]))
          .toList();
      if (contatosNessaLetra.isNotEmpty) {
        _contatosOrganizados[_alfabeto[i]] = contatosNessaLetra;
        _contatos.removeWhere(
            (contato) => contato.nome.toUpperCase().startsWith(_alfabeto[i]));
      }
    }
    if (_contatos.isNotEmpty) {
      _contatosOrganizados[_alfabeto[0]] = _contatos.map((e) => e).toList();
    }

    _loading = false;
    setState(() {});
  }

  _tapFloatingButton() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const FormContatoScreen();
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  @override
  Widget build(BuildContext context) {
    List<String> letrasComContato = _contatosOrganizados.keys.toList();
    letrasComContato.sort((a, b) => a.compareTo(b));

    return Scaffold(
      appBar: AppBar(title: const Text("Contatos")),
      floatingActionButton: FloatingActionButton(
        onPressed: _tapFloatingButton,
        tooltip: "Adicionar contato",
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : letrasComContato.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Nenhum contato"),
                  ),
                )
              : ListView.builder(
                  itemCount: _contatosOrganizados.keys.length,
                  itemBuilder: (context, index) {
                    String letra = letrasComContato.elementAt(index);
                    return StickyHeader(
                      header: Container(
                        width: double.infinity,
                        color: Colors.blueGrey[50],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Text(
                          letra,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      content: Column(
                        children: _contatosOrganizados[letra]!.map((contato) {
                          return ContatoListTile(contato);
                        }).toList(),
                      ),
                    );
                  },
                ),
    );
  }
}
