class ContatosListResponse {
  List<ContatoModel> contatos = [];

  ContatosListResponse({this.contatos = const []});

  ContatosListResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contatos = <ContatoModel>[];
      json['results'].forEach((v) {
        contatos.add(ContatoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = contatos.map((v) => v.toJson()).toList();
    return data;
  }
}

class ContatoModel {
  String objectId = "";
  String createdAt = "";
  String updatedAt = "";
  String nome = "";
  String sobrenome = "";
  String imagem = "";
  List<String> telefones = [];
  List<String> emails = [];

  ContatoModel(
      {this.objectId = "",
      this.createdAt = "",
      this.updatedAt = "",
      this.nome = "",
      this.sobrenome = "",
      this.imagem = "",
      this.telefones = const [],
      this.emails = const []});

  ContatoModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    nome = json['nome'];
    sobrenome = json['sobrenome'];
    imagem = json['imagem'];
    telefones = json['telefones'].cast<String>();
    emails = json['emails'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['nome'] = nome;
    data['sobrenome'] = sobrenome;
    data['imagem'] = imagem;
    data['telefones'] = telefones;
    data['emails'] = emails;
    return data;
  }

  Map<String, dynamic> toJsonData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['sobrenome'] = sobrenome;
    data['imagem'] = imagem;
    data['telefones'] = telefones;
    data['emails'] = emails;
    return data;
  }
}
