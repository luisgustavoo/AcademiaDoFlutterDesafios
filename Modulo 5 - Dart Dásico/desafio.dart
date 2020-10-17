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

  List<Pacient> patientList = [];
  for (var paciente in pacientes) {
    final listNames = paciente.split('|');
    patientList.add(Pacient(
        name: listNames[0].toString(),
        age: int.parse(listNames[1]),
        academicFormation: listNames[2].toString(),
        city: listNames[3].toString(),
        family: listNames[0].split(' ')[1]));
  }

  var family = '';

  patientList.sort((a, b) => a.family.compareTo(b.family));

  for (var p in patientList) {
    if ((family.isEmpty) || (family != p.family)) {
      print('Familia ${p.family}:');
      family = p.family;
    }

    print('     ${p.name}');
  }
}

class Pacient {
  Pacient(
      {this.name, this.age, this.academicFormation, this.city, this.family});

  String name;
  int age;
  String academicFormation;
  String city;
  String family;
}
