class StateModel {

  final int id;
  final String initials;
  final String name;

  StateModel({this.id, this.initials, this.name});

  factory StateModel.fromJson(Map<String, dynamic> json){
    return StateModel(id: json['id'], initials: json['sigla'], name: json['nome']);
  }

}