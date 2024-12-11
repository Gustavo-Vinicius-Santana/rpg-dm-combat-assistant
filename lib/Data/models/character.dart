class Character {
  final int? id;
  final String player;
  final String name;
  final String armor;
  final int lifeMax;
  final int lifeActual;
  final String condition1;
  final String condition2;
  final String condition3;
  final String condition4;

  Character({
    this.id,
    required this.player,
    required this.name,
    required this.armor,
    required this.lifeMax,
    required this.lifeActual,
    required this.condition1,
    required this.condition2,
    required this.condition3,
    required this.condition4,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'player': player,
        'name': name,
        'armor': armor,
        'lifeMax': lifeMax,
        'lifeActual': lifeActual,
        'condition_1': condition1,
        'condition_2': condition2,
        'condition_3': condition3,
        'condition_4': condition4,
      };

  static Character fromMap(Map<String, dynamic> map) => Character(
        id: map['id'],
        player: map['player'],
        name: map['name'],
        armor: map['armor'],
        lifeMax: map['lifeMax'],
        lifeActual: map['lifeActual'],
        condition1: map['condition_1'],
        condition2: map['condition_2'],
        condition3: map['condition_3'],
        condition4: map['condition_4'],
      );
}
