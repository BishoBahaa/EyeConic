import 'package:eye_diseases/models/diseases_model.dart';
import 'package:flutter/material.dart';

class DiseaseItem extends StatelessWidget {
  const DiseaseItem({
    required this.dmodel,
    this.onTap,
    super.key,
  });
  final DiseasesModel dmodel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: double.infinity,
        height: 420,
        color: dmodel.color,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${dmodel.name}",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.blueGrey[100],
                    fontWeight: FontWeight.w500),
              ),
              const Divider(
                height: 32,
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
