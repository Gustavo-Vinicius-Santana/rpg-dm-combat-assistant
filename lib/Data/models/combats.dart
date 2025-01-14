class Combats {
  final int? id;
  final String name;
  final int turns;
  final String time;

  Combats({
    this.id,
    required this.name,
    required this.turns,
    required this.time,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'turns': turns,
        'time': time,
      };

  static Combats fromMap(Map<String, dynamic> map) => Combats(
        id: map['id'],
        name: map['name'],
        turns: map['turns'],
        time: map['time'],
      );
}
