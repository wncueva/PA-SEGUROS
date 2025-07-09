import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewsmodels/poliza_viewmodel.dart';
import 'poliza_detalle_view.dart';

class ListaUsuariosView extends StatelessWidget {
  final List<String> usuarios;

  const ListaUsuariosView({
    required this.usuarios,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PolizaViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Usuarios"), backgroundColor: Colors.teal),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final nombre = usuarios[index];
          return ListTile(
            title: Text(nombre),
            onTap: () async {
              final resumen = await vm.obtenerResumenDe(nombre);
              if (resumen != null && context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PolizaDetalleView(resumen: resumen),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No se pudo obtener el resumen')),
                );
              }
            },
          );
        },
      ),
    );
  }
}