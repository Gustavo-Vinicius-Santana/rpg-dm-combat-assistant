class Monsters {
  final int? id;
  final String name;
  final String armor;
  final String lifeMax;
  final String lifeActual;
  final String condition;

  Monsters(
      {this.id,
      required this.name,
      required this.armor,
      required this.lifeMax,
      required this.lifeActual,
      required this.condition});

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'armor': armor,
        'lifeMax': lifeMax,
        'lifeActual': lifeActual,
        'condition_1': condition,
      };

  static Monsters fromMap(Map<String, dynamic> map) => Monsters(
        id: map['id'],
        name: map['name'],
        armor: map['armor'],
        lifeMax: map['lifeMax'],
        lifeActual: map['lifeActual'],
        condition: map['condition_1'],
      );
}
