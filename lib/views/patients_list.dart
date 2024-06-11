import 'package:eye_diseases/models/doctors_patient_model.dart';
import 'package:eye_diseases/services/doctor_api.dart';
import 'package:eye_diseases/views/model_view.dart';
import 'package:eye_diseases/widgets/patient_item.dart';
import 'package:flutter/material.dart';

class PatientsListView extends StatefulWidget {
  const PatientsListView({super.key});

  @override
  State<PatientsListView> createState() => _PatientsListViewState();
}

class _PatientsListViewState extends State<PatientsListView> {
  // final List<DoctorsPatientModel> patientsList = [
  //   DoctorsPatientModel(
  //       pFirstName: 'Ashraf Khaled',
  //       pLastName: "",
  //       pImage: 'assets/images/eye-scan.png'),
  //   DoctorsPatientModel(
  //       pFirstName: 'Ashraf Khaled',
  //       pLastName: "",
  //       pImage: 'assets/images/eye-scan.png'),
  //   DoctorsPatientModel(
  //       pFirstName: 'Ashraf Khaled',
  //       pLastName: "",
  //       pImage: 'assets/images/eye-scan.png'),
  //   DoctorsPatientModel(
  //       pFirstName: 'Ashraf Khaled',
  //       pLastName: "",
  //       pImage: 'assets/images/eye-scan.png'),
  //   DoctorsPatientModel(
  //       pFirstName: 'Ashraf Khaled',
  //       pLastName: "",
  //       pImage: 'assets/images/eye-scan.png'),
  // ];


  List<DoctorsPatientModel> patient = [];

  @override
  void initState() {
    super.initState();
    getAllDoctors();
  }

  Future<void> getAllDoctors() async {
    patient = await DoctorApiService().getAllPatient();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff485190),
          title: const Text(
            'Patients List',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: patient.length,
          itemBuilder: (context, index) {
            return PatientItem(
             patientModel: patient[index],
            // Pass a callback to navigate to ModelView with the image URL
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ModelView(imageUrl: patient[index].pImage),));}
            );
          },
        ));
  }
}
