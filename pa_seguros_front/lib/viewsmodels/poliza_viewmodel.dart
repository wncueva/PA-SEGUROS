import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/poliza_model.dart';

class PolizaViewModel extends ChangeNotifier {
  String propietario = '';
  double valorSeguroAuto = 0;
  String modeloAuto = 'A';
  String edadPropietario = '18-23';
  int accidentes = 0;
  double costoTotal = 0;
  Poliza? resumen;

  final String apiUrl = 'http://10.0.2.2:9090/bdd_dto/api/poliza';

  int _edadToInt(String rango) {
    switch (rango) {
      case '18-23':
        return 20;
      case '23-55':
        return 35;
      case '55+':
        return 60;
      default:
        return 18;
    }
  }

  Future<void> calcularPoliza() async {
    if (valorSeguroAuto < 0 || accidentes < 0) {
      print('Valores negativos no permitidos');
      return;
    }

    final poliza = Poliza(
      propietario: propietario,
      valorSeguroAuto: valorSeguroAuto,
      modeloAuto: modeloAuto,
      edadPropietario: _edadToInt(edadPropietario),
      accidentes: accidentes,
      costoTotal: costoTotal,
    );

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(poliza.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      resumen = Poliza.fromJson(data);
      costoTotal = resumen?.costoTotal ?? 0;
      notifyListeners();

      // Limpiar campos del formulario pero conservar el resumen y costoTotal
      propietario = '';
      valorSeguroAuto = 0;
      modeloAuto = 'A';
      edadPropietario = '18-23';
      accidentes = 0;
    } else {
      print('Error al calcular póliza: ${response.statusCode}');
    }
  }

  Future<List<String>> obtenerPropietarios() async {
    final res = await http.get(Uri.parse('http://10.0.2.2:9090/bdd_dto/api/propietarios'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return List<String>.from(data.map((e) => e['nombreCompleto']));
    } else {
      print('Error al obtener propietarios: ${res.statusCode}');
      return [];
    }
  }

  Future<void> cargarPolizaDe(String nombre) async {
    final res = await http.get(Uri.parse('http://10.0.2.2:9090/bdd_dto/api/poliza/usuario?nombre=$nombre'));
    if (res.statusCode == 200) {
      resumen = Poliza.fromJson(jsonDecode(res.body));
      costoTotal = resumen?.costoTotal ?? 0;
      notifyListeners();
    } else {
      print('Error al cargar póliza de usuario $nombre: ${res.statusCode}');
    }
  }
  Future<Poliza?> obtenerResumenDe(String nombre) async {
    final res = await http.get(Uri.parse('http://10.0.2.2:9090/bdd_dto/api/poliza/usuario?nombre=$nombre'));
    if (res.statusCode == 200) {
      return Poliza.fromJson(jsonDecode(res.body));
    }
    return null;
  }
}