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

  // ** Apresente a quantidade de pacientes com mais de 20 anos
  print('Apresente a quantidade de pacientes com mais de 20 anos');
  print(
      'Existem ${pacientes.where((p) => int.parse(p.split('|')[1]) > 20).length} com mais de 20 anos');

  print('========================================');

  // ** Agrupar os pacientes por familia(considerar o sobrenome) apresentar por familia.
  print(
      'Agrupar os pacientes por familia(considerar o sobrenome) apresentar por familia.');

  List<Paciente> listaDePacientes = [];

  pacientes.forEach((paciente) {
    final listaDeNomes = paciente.split('|');
    listaDePacientes.add(Paciente(
        nome: listaDeNomes[0].toString(),
        idade: int.parse(listaDeNomes[1]),
        formacao: listaDeNomes[2].toString(),
        estado: listaDeNomes[3].toString(),
        familia: listaDeNomes[0].split(' ')[1].toString()));
  });

  var familia = '';
  listaDePacientes.sort((a, b) => a.familia.compareTo(b.familia));

  listaDePacientes.forEach((paciente) {
    if ((familia.isEmpty) || (familia != paciente.familia)) {
      print('Familia ${paciente.familia}:');
      familia = paciente.familia;
    }
    print('     ${paciente.nome}');
  });
}

class Paciente {
  Paciente({this.nome, this.idade, this.formacao, this.estado, this.familia});

  String nome;
  int idade;
  String formacao;
  String estado;
  String familia;
}
