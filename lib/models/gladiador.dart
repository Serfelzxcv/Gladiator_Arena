import 'dart:math';

class Gladiator {
  String name;
  int health;
  int attackPower;
  double specialMoveChance; // Probabilidad de golpe mortal
  String subclass;
  String imagePath;

  Gladiator({
    required this.name,
    required this.health,
    required this.attackPower,
    required this.specialMoveChance,
    required this.subclass,
    required this.imagePath,
  });

  // Método para realizar un ataque
  void attack(Gladiator opponent) {
    if (Random().nextDouble() < specialMoveChance) {
      opponent.health = 0; // Golpe mortal
    } else {
      opponent.health -= attackPower; // Ataque normal
    }
  }
}
