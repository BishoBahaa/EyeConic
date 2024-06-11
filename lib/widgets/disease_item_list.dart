import 'package:eye_diseases/views/cataract_view.dart';
import 'package:eye_diseases/views/diabetic_retinopathy_view.dart';
import 'package:eye_diseases/views/glaucoma_view.dart';
import 'package:eye_diseases/Widgets/disease_item.dart';
import 'package:eye_diseases/models/diseases_model.dart';
import 'package:eye_diseases/views/retina_view.dart';
import 'package:flutter/material.dart';

class DiseaseItemList extends StatelessWidget {
  DiseaseItemList({super.key});

  final List<DiseasesModel> dmodel = [
    DiseasesModel(
        name: "Cataract",
        color: const Color(
          0xFF74BCD5,
        )),
    DiseasesModel(name: "Glaucoma", color: const Color(0xFF8078B5)),
    DiseasesModel(name: "Diabetic Retinopathy", color: const Color(0xFFE08E86)),
    DiseasesModel(name: "Retina", color: const Color.fromARGB(255, 224, 189, 134)),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return DiseaseItem(
        dmodel: dmodel[index],
        onTap: () {
          // Navigate to the appropriate screen:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _navigateToScreen(dmodel[index]),
            ),
          );
        },
      );
    }, childCount: dmodel.length));
  }

  Widget _navigateToScreen(DiseasesModel disease) {
    switch (disease.name) {
      case "Cataract":
        return CataractView(values: disease);

      case "Glaucoma":
        return GlaucomaView(values: disease);

      case "Diabetic Retinopathy":
        return DiabeticRetinopathyView(values: disease);
      case "Retina":
        return RetinaView(values: disease);

      default:
        // Handle unexpected cases gracefully
        return const Text('Error: Unknown disease');
    }
  }
}
