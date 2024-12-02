// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:gladiator_game/models/gladiador.dart';
// import 'package:gladiator_game/services/gladiator_service.dart';

// class GladiatorBattle extends StatefulWidget {
//   @override
//   _GladiatorBattleState createState() => _GladiatorBattleState();
// }

// class _GladiatorBattleState extends State<GladiatorBattle> {
//   GladiatorService service = GladiatorService();
//   late Gladiator gladiator1;
//   late Gladiator gladiator2;
//   Timer? _timer;
//   List<String> battleLog = []; // Aquí se guardan los eventos del combate
//   List<Gladiator> gladiators = []; // Lista para almacenar los gladiadores obtenidos

//   @override
//   void initState() {
//     super.initState();
//     _initializeCombat();
//     _loadGladiators();  // Cargar los gladiadores desde el servicio
//   }

//   // Función para cargar gladiadores desde el servicio
//   Future<void> _loadGladiators() async {
//     try {
//       List<Gladiator> fetchedGladiators = await service.fetchGladiators();
//       setState(() {
//         gladiators = fetchedGladiators;
//         // Asegúrate de que la lista de gladiadores no esté vacía antes de asignar a gladiator1 y gladiator2
//         if (gladiators.isNotEmpty) {
//           gladiator1 = gladiators[0]; // Asigna un gladiador de la lista
//           gladiator2 = gladiators[1]; // Asigna otro gladiador
//         }
//       });
//     } catch (e) {
//       print('Error al cargar gladiadores: $e');
//     }
//   }

//   // Función para inicializar el combate
//   void _initializeCombat() {
//     gladiator1 = Gladiator(
//       name: 'Secutor',
//       health: 100,
//       attackPower: 15,
//       specialMoveChance: 0.10,
//       subclass: 'Secutor',
//       imagePath: 'assets/gladiators/gladiator1.png',
//     );

//     gladiator2 = Gladiator(
//       name: 'Retiarius',
//       health: 100,
//       attackPower: 10,
//       specialMoveChance: 0.15,
//       subclass: 'Retiarius',
//       imagePath: 'assets/gladiators/gladiator2.png',
//     );

//     battleLog.clear(); // Limpiamos el historial de la batalla
//   }

//   // Función para iniciar el combate
//   void startCombat() {
//     if (gladiator1.health <= 0 || gladiator2.health <= 0) {
//       // Evitar iniciar combate si alguno de los gladiadores está muerto
//       return;
//     }
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       // Si alguno de los gladiadores ya ha muerto, detén el combate
//       if (gladiator1.health <= 0 || gladiator2.health <= 0) {
//         _timer?.cancel();
//         if (gladiator1.health <= 0) {
//           battleLog.add("${gladiator1.name} ha muerto. ${gladiator2.name} gana el combate!");
//         } else if (gladiator2.health <= 0) {
//           battleLog.add("${gladiator2.name} ha muerto. ${gladiator1.name} gana el combate!");
//         }
//         setState(() {});
//         return; // Termina la ejecución si el combate ha terminado
//       }

//       // Gladiador 1 ataca
//       gladiator1.attack(gladiator2);
//       if (gladiator2.health <= 0) {
//         battleLog.add("${gladiator1.name} realiza un golpe mortal y derrota a ${gladiator2.name}!");
//       } else {
//         battleLog.add("${gladiator1.name} ataca a ${gladiator2.name} y le hace ${gladiator1.attackPower} de daño.");
//       }

//       // Gladiador 2 ataca si está vivo
//       if (gladiator2.health > 0) {
//         gladiator2.attack(gladiator1);
//         if (gladiator1.health <= 0) {
//           battleLog.add("${gladiator2.name} realiza un golpe mortal y derrota a ${gladiator1.name}!");
//         } else {
//           battleLog.add("${gladiator2.name} ataca a ${gladiator1.name} y le hace ${gladiator2.attackPower} de daño.");
//         }
//       }

//       setState(() {});
//     });
//   }

//   // Función para reiniciar el combate
//   void restartCombat() {
//     setState(() {
//       _initializeCombat();  // Restablecer el estado de los gladiadores
//       _timer?.cancel();     // Detener el temporizador del combate anterior
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Combate de Gladiadores'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Selección de gladiadores
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Usar Image.network para cargar imágenes desde la URL
//               Image.network(gladiator1.imagePath, width: 100, height: 100),
//               SizedBox(width: 20),
//               Image.network(gladiator2.imagePath, width: 100, height: 100),
//             ],
//           ),

//             SizedBox(height: 20),
//             // Barra de vida
//             Text('Vida de ${gladiator1.name}: ${gladiator1.health}'),
//             LinearProgressIndicator(
//               value: gladiator1.health / 100,
//               backgroundColor: Colors.red,
//               valueColor: AlwaysStoppedAnimation(Colors.green),
//             ),
//             SizedBox(height: 10),
//             Text('Vida de ${gladiator2.name}: ${gladiator2.health}'),
//             LinearProgressIndicator(
//               value: gladiator2.health / 100,
//               backgroundColor: Colors.red,
//               valueColor: AlwaysStoppedAnimation(Colors.green),
//             ),
//             SizedBox(height: 20),
//             // Relato del combate
//             Expanded(
//               child: ListView.builder(
//                 itemCount: battleLog.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(battleLog[index]),
//                   );
//                 },
//               ),
//             ),
//             // Botón de iniciar combate
//             ElevatedButton(
//               onPressed: gladiators.isNotEmpty ? startCombat : null, // Asegúrate de que los gladiadores estén disponibles
//               child: Text('Iniciar Combate'),
//             ),
//             // Botón de reiniciar combate
//             ElevatedButton(
//               onPressed: restartCombat,
//               child: Text('Reiniciar Combate'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
