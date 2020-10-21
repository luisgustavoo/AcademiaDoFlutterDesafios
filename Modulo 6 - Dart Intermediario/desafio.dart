void main() {
  var pessoas = [
    'Rodrigo Rahman|35|Masculino',
    'Jose|56|Masculino',
    'Joaquim|84|Masculino',
    'Rodrigo Rahman|35|Masculino',
    'Maria|88|Feminino',
    'Helena|24|Feminino',
    'Leonardo|5|Masculino',
    'Laura Maria|29|Feminino',
    'Joaquim|72|Masculino',
    'Helena|24|Feminino',
    'Guilherme|15|Masculino',
    'Manuela|85|Masculino',
    'Leonardo|5|Masculino',
    'Helena|24|Feminino',
    'Laura|29|Feminino',
  ];

  // ! 1 - Remover os duplicados
  // ! 2 - Me mostre a quantidade de pessoas do sexo Masculino e Feminino
  // ! 3 - Filtrar e deixar a lista somente com pessoas maiores de 18 anos  e mostre a quantidade de pessoas com mais de 18 anos
  // ! 4 - Encontre a pessoa mais velha.

  var listaDePessoas = List<Pessoa>.from([]);
  pessoas.forEach((p) {
    final pessoa = p.split('|');
    listaDePessoas.add(Pessoa(
        nome: pessoa[0].toString(),
        idade: int.tryParse(pessoa[1]) ?? 0,
        sexo: pessoa[2].toString()));
  });

  // **1 - Remover os duplicados
  print('Remover os duplicados');
  var listaDePessoasSemDuplcidade = Set<Pessoa>.from({});
  listaDePessoas.forEach((p) {
    listaDePessoasSemDuplcidade.add(p);
  });

  listaDePessoasSemDuplcidade.forEach((p) {
    print('nome: ${p.nome} idade: ${p.idade} sexo: ${p.sexo} ');
  });

  print('');
  print('====================================');
  // **2 - Me mostre a quantidade de pessoas do sexo Masculino e Feminino
  print('Me mostre a quantidade de pessoas do sexo Masculino e Feminino');
  print(
      'Masculino: ${listaDePessoasSemDuplcidade.toList().where((p) => p.sexo == 'Masculino').length}');
  print(
      'Feminino: ${listaDePessoasSemDuplcidade.toList().where((p) => p.sexo == 'Feminino').length} ');

  print('');
  print('====================================');
  // **3 - Filtrar e deixar a lista somente com pessoas maiores de 18 anos  e mostre a quantidade de pessoas com mais de 18 anos
  print(
      'Filtrar e deixar a lista somente com pessoas maiores de 18 anos  e mostre a quantidade de pessoas com mais de 18 anos');
  listaDePessoasSemDuplcidade.retainWhere((p) => p.idade > 18);
  listaDePessoasSemDuplcidade.forEach((p) {
    print('nome: ${p.nome} idade: ${p.idade} sexo: ${p.sexo} ');
  });

  print(
      'Quantidade de pessoas maiores de 18 anos: ${listaDePessoasSemDuplcidade.length} ');

  print('');
  print('====================================');
  // **4 - Encontre a pessoa mais velha.
  listaDePessoas.clear();

  listaDePessoas = listaDePessoasSemDuplcidade.map((p) => p).toList();

  listaDePessoas.sort((a, b) => a.idade.compareTo(b.idade));

  print(
      'Pessoa mais velha é: ${listaDePessoas.last.nome} idade ${listaDePessoas.last.idade}');
}

class Pessoa {
  Pessoa({this.nome, this.idade, this.sexo});

  final String nome;
  final int idade;
  final String sexo;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Pessoa && o.nome == nome && o.idade == idade && o.sexo == sexo;
  }

  @override
  int get hashCode => nome.hashCode ^ idade.hashCode ^ sexo.hashCode;
}
