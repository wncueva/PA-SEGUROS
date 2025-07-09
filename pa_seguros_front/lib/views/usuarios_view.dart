import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewsmodels/poliza_viewmodel.dart';
import '../views/poliza_detalle_view.dart';

class UsuariosView extends StatelessWidget {
  const UsuariosView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PolizaViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Propietarios'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<String>>(
        future: vm.obtenerPropietarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay propietarios registrados.'));
          }

          final propietarios = snapshot.data!;

          return ListView.separated(
            padding: EdgeInsets.all(16),
            itemCount: propietarios.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, index) {
              final nombre = propietarios[index];
              return ListTile(
                title: Text(nombre),
                leading: Icon(Icons.person, color: Colors.teal),
                  onTap: () async {
                    final resumen = await vm.obtenerResumenDe(nombre);
                    if (resumen != null && context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PolizaDetalleView(resumen: resumen),
                        ),
                      );
                    }
                  }
              );
            },
          );
        },
      ),
    );
  }
}
