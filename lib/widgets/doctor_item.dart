import 'package:eye_diseases/models/all_doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final AllDoctors doctor;
  final VoidCallback onPressed;

  const DoctorCard({
    required this.doctor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
CircleAvatar(
  radius: 52.0,
  backgroundColor: Colors.teal,
  child: CircleAvatar( radius: 50.0,
  
                 child: ClipOval(
          child: Image.network(
              doctor.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ), ),),
),
         
          SizedBox(height: 10),
          Text(
            'Dr.${doctor.fname} ${doctor.lname}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text('Email: ${doctor.email}'),
          Text('Phone: ${doctor.phone}'),
          Text('Qualifications: ${doctor.qualifications}'),
          SizedBox(height: 10),
          
          ElevatedButton(
            onPressed: onPressed ,
            child: const Text('Send Eye Funds Image'),
          ),
        ],
      ),
    );
  }
}
