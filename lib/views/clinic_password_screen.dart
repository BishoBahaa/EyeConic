import 'package:eye_diseases/services/doctor_api.dart';
import 'package:eye_diseases/util/form_validation.dart';
import 'package:flutter/material.dart';

class ClinicPassword extends StatefulWidget {
  const ClinicPassword({super.key});

  @override
  State<ClinicPassword> createState() => _ClinicPasswordState();
}

class _ClinicPasswordState extends State<ClinicPassword> {
  Future<void> _sendClinicPassword() async {
    if (_formKey.currentState!.validate()) {
      DoctorApiService().sendClinicPassword(_passwordController.text, context);
    }
  }
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            )),
        title: const Text(
          'Clinic Password',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff222744),
                Color(0xff485190),
              ],
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff222744),
                      Color(0xff485190),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(42))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Image.asset(
                  'assets/images/eye-scan.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                                    SizedBox(height: 25,),

                  TextFormField(
                    key: const ValueKey('password'),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: ' Enter Clinic Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: const Icon(Icons.lock_rounded),
                      // Optional: Add an icon button to toggle password visibility
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Use appropriate icon based on visibility state:
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() => _showPassword = !_showPassword);
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText:
                        !_showPassword, // Control password visibility based on _showPassword state
                    validator: (value) {
                      return FormValidation().passwordVal(value);
                    },
                  ),
                  SizedBox(height: 25,),
                  ElevatedButton(
                    onPressed: () {
                      _sendClinicPassword();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
