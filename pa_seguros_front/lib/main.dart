import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/poliza_view.dart';
import 'viewsmodels/poliza_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PolizaViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestión de Pólizas',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        home: PolizaView(),
      ),
    );
  }
}
