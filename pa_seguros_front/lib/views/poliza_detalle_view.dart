import 'package:flutter/material.dart';
import '../models/poliza_model.dart';

class PolizaDetalleView extends StatelessWidget {
  final Poliza resumen;

  const PolizaDetalleView({super.key, required this.resumen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resumen de la Póliza"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(3),
          },
          children: [
            _buildRow("Propietario", resumen.propietario),
            _buildRow("Modelo", resumen.modeloAuto),
            _buildRow("Valor Seguro", "\$${resumen.valorSeguroAuto.toStringAsFixed(2)}"),
            _buildRow("Edad", resumen.edadPropietario.toString()),
            _buildRow("Accidentes", resumen.accidentes.toString()),
            _buildRow("Costo Total", "\$${resumen.costoTotal.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }

  TableRow _buildRow(String campo, String valor) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(campo, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(valor),
      ),
    ]);
  }
}