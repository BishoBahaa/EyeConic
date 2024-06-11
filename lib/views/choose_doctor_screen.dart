import 'package:eye_diseases/models/all_doctor_model.dart';
import 'package:eye_diseases/services/patient_api.dart';
import 'package:eye_diseases/views/send_image.dart';
import 'package:eye_diseases/widgets/doctor_item.dart';
import 'package:flutter/material.dart';

class ChooseDoctorScreen extends StatefulWidget {
  const ChooseDoctorScreen({
    super.key,
  });

  @override
  State<ChooseDoctorScreen> createState() => _ChooseDoctorScreenState();
}

class _ChooseDoctorScreenState extends State<ChooseDoctorScreen> {
  List<AllDoctors> doctors = [];

  @override
  void initState() {
    super.initState();
    getAllDoctors();
  }

  Future<void> getAllDoctors() async {
    doctors = await PatientApiService().getAllDoctors();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Doctor'),
                  backgroundColor: Color(0xff485190),

      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(
            doctor: doctors[index],
            onPressed: () {
Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SendImage(),
            ));             
             PatientApiService().chooseDoctor(doctors[index].id, context);
            },
          );
        },
      ),
    );
  }
}
