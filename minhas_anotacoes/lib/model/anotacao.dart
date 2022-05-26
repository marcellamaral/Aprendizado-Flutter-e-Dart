class Anotacao {
  int? id;
  String titulo;
  String descricao;
  String data;

  Anotacao(this.titulo, this.descricao, this.data);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "titulo": this.titulo,
      "descricao": this.descricao,
      "data": this.data,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }
}
