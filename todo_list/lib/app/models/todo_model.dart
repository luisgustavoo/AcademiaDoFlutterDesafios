class TodoModel {
  int id;
  String descricao;
  DateTime dataHora;
  bool finalizado;

  TodoModel({this.id, this.descricao, this.dataHora, this.finalizado});

  factory TodoModel.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return TodoModel(
        id: map['id'] as int,
        descricao: map['descricao'] as String,
        dataHora: DateTime.parse(map['data_hora']),
        finalizado: map['finalizado']  == 0 ? false : true
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'data_hora': dataHora,
      'finalizado': finalizado
    };
  }
}
