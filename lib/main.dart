import 'package:flutter/material.dart';
import 'package:gladiator_game/screens/gladiator_battle.dart';

void main(){
  runApp(GladiatorGame());
}

class GladiatorGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego de Gladiadores',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GladiatorBattle(),
    );
  }
  
}