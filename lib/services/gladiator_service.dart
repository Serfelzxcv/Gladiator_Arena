import 'dart:convert'; // Para trabajar con JSON
import 'package:gladiator_game/models/gladiador.dart'; // Asegúrate de que el modelo Gladiator esté importado correctamente
import 'package:http/http.dart' as http;
import 'dart:async'; // Para usar las funcionalidades asincrónicas

class GladiatorService {
  // Método para obtener gladiadores desde la API
  Future<List<Gladiator>> getFetchGladiators() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/gladiadores/'));

    if (response.statusCode == 200) {
      print("Conexión correcta");
      // Si la respuesta es exitosa (código 200), decodificamos el JSON
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Gladiator.fromJson(item)).toList();  // Convertimos el JSON a Gladiator
      
    } else {
      print("Conexión incorrecta");
      // Si la respuesta no es exitosa, lanzamos una excepción
      throw Exception('Failed to load gladiators');
    }
  }

  // Método para enviar Gladiator a la API
  Future<void> createGladiator(Gladiator gladiator) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/gladiadores/');  // Asegúrate de usar tu URL real
    print('JSON enviado: ${json.encode(gladiator.toJson())}');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(gladiator.toJson()),  // Usamos el método toJson() del objeto Gladiator
      );

      if (response.statusCode == 201) {
        print('Gladiator creado exitosamente!');
      } else {
        print('Error al crear Gladiator: ${response.statusCode}');
        print('Error al crear Gladiator: ${response.statusCode}');
        print('Cuerpo de respuesta: ${response.body}');
      }
    } catch (e) {
      print('Error al enviar los datos: $e');
    }
  }
}
