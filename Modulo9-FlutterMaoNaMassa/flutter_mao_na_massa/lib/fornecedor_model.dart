class Fornecedor {
  String tipo;
  String nome;
  String cor;
  double nota;
  String tempoMedio;
  bool melhorPreco;
  double preco;

  Fornecedor(
      {this.tipo,
      this.nome,
      this.cor,
      this.nota,
      this.tempoMedio,
      this.melhorPreco,
      this.preco});

  factory Fornecedor.fromJson(Map<String, dynamic> json) {
    return Fornecedor(
        tipo: json['tipo'] as String,
        nome: json['nome'] as String,
        cor: json['cor'] as String,
        nota: json['nota'] as double,
        tempoMedio: json['tempoMedio'] as String,
        melhorPreco: json['melhorPreco'] as bool,
        preco: json['preco'] as double);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tipo'] = tipo;
    data['nome'] = nome;
    data['cor'] = cor;
    data['nota'] = nota;
    data['tempoMedio'] = tempoMedio;
    data['melhorPreco'] = melhorPreco;
    data['preco'] = preco;
    return data;
  }
}
