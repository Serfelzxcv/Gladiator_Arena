import 'dart:math';
import 'dart:typed_data';

class Gladiator {
  String        name;
  int           health;
  int           attackPower;
  double        specialMoveChance; // Probabilidad de golpe mortal
  String        subclass;
  Uint8List?    imageData;

  Gladiator({
    required    this.name,
    required    this.health,
    required    this.attackPower,
    required    this.specialMoveChance,
    required    this.subclass,
    this.imageData,
  });

  // Método para realizar un ataque
  void attack(Gladiator opponent) {
    if (Random().nextDouble() < specialMoveChance) {
      opponent.health = 0; // Golpe mortal
    } else {
      opponent.health -= attackPower; // Ataque normal
    }
  }

  // fromJson: Crear una instancia de Gladiator a partir de un mapa
  factory Gladiator.fromJson(Map<String, dynamic> json) {
    return Gladiator(
      name:                 json['name'],
      health:               json['health'],
      attackPower:          json['attackPower'],
      specialMoveChance:    json['specialMoveChance'],
      subclass:             json['subclass'],
      imageData:            json['imageData'] != null? Uint8List.fromList(List<int>.from(json['imageData'])): null,
    );
  }

  // toJson: Convertir una instancia de Gladiator a un mapa
  Map<String, dynamic> toJson() {
    return {
      'name':                 name,
      'health':               health,
      'attackPower':          attackPower,
      'specialMoveChance':    specialMoveChance,
      'subclass':             subclass,
      'imageData':            imageData?.toList(),
    };
  }
}
