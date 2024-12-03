import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gladiator_game/services/gladiator_service.dart'; // Asegúrate de importar tu servicio
import 'package:gladiator_game/models/gladiador.dart'; // Asegúrate de importar tu modelo

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _health = 100;
  int _attackPower = 50;
  double _specialMoveChance = 0.2;
  String _subclass = '';
  Uint8List? _imageData;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _healthController = TextEditingController();
  final TextEditingController _attackPowerController = TextEditingController();
  final TextEditingController _specialMoveChanceController = TextEditingController();
  final TextEditingController _subclassController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageData = File(pickedFile.path).readAsBytesSync();
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Gladiator newGladiator = Gladiator(
        name: _name,
        health: _health,
        attackPower: _attackPower,
        specialMoveChance: _specialMoveChance,
        subclass: _subclass,
        // Si tu modelo incluye una propiedad para la imagen, agrégala aquí
        // image: _imageData,
      );

      GladiatorService().createGladiator(newGladiator);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gladiator creado exitosamente!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Gladiador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nombre del Gladiador'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un nombre';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                TextFormField(
                  controller: _healthController,
                  decoration: InputDecoration(labelText: 'Salud'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un valor de salud';
                    }
                    return null;
                  },
                  onSaved: (value) => _health = int.parse(value!),
                ),
                TextFormField(
                  controller: _attackPowerController,
                  decoration: InputDecoration(labelText: 'Poder de Ataque'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un valor de poder de ataque';
                    }
                    return null;
                  },
                  onSaved: (value) => _attackPower = int.parse(value!),
                ),
                TextFormField(
                  controller: _specialMoveChanceController,
                  decoration: InputDecoration(labelText: 'Probabilidad de Golpe Mortal'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un valor de probabilidad';
                    }
                    return null;
                  },
                  onSaved: (value) => _specialMoveChance = double.parse(value!),
                ),
                TextFormField(
                  controller: _subclassController,
                  decoration: InputDecoration(labelText: 'Subclase'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una subclase';
                    }
                    return null;
                  },
                  onSaved: (value) => _subclass = value!,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Seleccionar Imagen'),
                ),
                if (_imageData != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Image.memory(
                      _imageData!,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Crear Gladiador'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
