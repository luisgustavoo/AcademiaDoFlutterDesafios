void main() {
  var pacientes = [
    'Rodrigo Rahman|35|desenvolvedor|SP',
    'Manoel Silva|12|estudante|MG',
    'Joaquim Rahman|18|estudante|SP',
    'Fernando Verne|35|estudante|MG',
    'Gustavo Silva|40|estudante|MG',
    'Sandra Silva|40|estudante|MG',
    'Regina Verne|35|estudante|MG',
    'João Rahman|55|Jornalista|SP',
  ];

  pacientes.retainWhere((p) => int.parse(p.split('|')[1]) > 20);

  // ** Apresente a quantidade de pacientes com mais de 20 anos
  print('Apresente a quantidade de pacientes com mais de 20 anos');
  print('Existem ${pacientes.length} com mais de 20 anos');

  print('========================================');

  // ** Agrupar os pacientes por familia(considerar o sobrenome) apresentar por familia.
  print(
      'Agrupar os pacientes por familia(considerar o sobrenome) apresentar por familia.');
  pacientes = [
    'Rodrigo Rahman|35|desenvolvedor|SP',
    'Manoel Silva|12|estudante|MG',
    'Joaquim Rahman|18|estudante|SP',
    'Fernando Verne|35|estudante|MG',
    'Gustavo Silva|40|estudante|MG',
    'Sandra Silva|40|estudante|MG',
    'Regina Verne|35|estudante|MG',
    'João Rahman|55|Jornalista|SP',
  ];

  List<Paciente> listaDePacientes = [];
  for (var paciente in pacientes) {
    final listaDeNomes = paciente.split('|');
    listaDePacientes.add(Paciente(
        nome: listaDeNomes[0].toString(),
        idade: int.parse(listaDeNomes[1]),
        formacao: listaDeNomes[2].toString(),
        cidade: listaDeNomes[3].toString(),
        familia: listaDeNomes[0].split(' ')[1]));
  }

  var familia = '';
  listaDePacientes.sort((a, b) => a.familia.compareTo(b.familia));
  for (var p in listaDePacientes) {
    if ((familia.isEmpty) || (familia != p.familia)) {
      print('Familia ${p.familia}:');
      familia = p.familia;
    }
    print('     ${p.nome}');
  }
}

class Paciente {
  Paciente({this.nome, this.idade, this.formacao, this.cidade, this.familia});

  String nome;
  int idade;
  String formacao;
  String cidade;
  String familia;
}
