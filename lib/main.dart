import 'package:eye_diseases/views/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EyeDiseases());
}

class EyeDiseases extends StatelessWidget {
  const EyeDiseases({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
