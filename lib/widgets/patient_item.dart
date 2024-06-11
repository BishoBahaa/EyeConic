import 'package:eye_diseases/models/doctors_patient_model.dart';
import 'package:flutter/material.dart';

class PatientItem extends StatelessWidget {
  const PatientItem({
    super.key,
    required this.patientModel,
    required this.onTap,
  });
  final DoctorsPatientModel patientModel;
  final VoidCallback onTap; // Callback to handle tap events

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 148, 163, 245),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(patientModel.pImage.toString()),
              ),
            ),
            SizedBox(
              width: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        patientModel.pFirstName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        patientModel.pLastName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Text(
                  //   "Report: ${patientModel.report}",
                  //   style: const TextStyle(
                  //     fontSize: 20,
                  //     color: Colors.blueGrey,
                  //     fontWeight: FontWeight.w500
                  //   ),
                  // ),
                  const SizedBox(
                    height:8,
                  ),
                 Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: onTap, // Trigger the onTap callback when pressed
                        child: const Text('Send to Model'),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
