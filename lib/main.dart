import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/catalog_screen.dart';

void main() {
  runApp(const ProviderScope(child: BeddingApp()));
}

class BeddingApp extends StatelessWidget {
  const BeddingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Постельное белье',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const CatalogScreen(),
    );
  }
}