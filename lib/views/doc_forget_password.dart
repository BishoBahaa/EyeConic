import 'package:eye_diseases/models/doc_reset_pass_model.dart';
import 'package:flutter/material.dart';
import 'package:eye_diseases/services/doctor_api.dart';
import '../util/form_validation.dart';

class DocForgetPassword extends StatefulWidget {
  const DocForgetPassword({Key? key}) : super(key: key);

  @override
  State<DocForgetPassword> createState() => _DocForgetPasswordState();
}

class _DocForgetPasswordState extends State<DocForgetPassword> {
  final _emailFormKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final passController = TextEditingController();
  final confirmpassController = TextEditingController();

  bool passToggle = true;

  Future<void> _sendCode() async {
    if (_emailFormKey.currentState!.validate()) {
      DoctorApiService().sendForgetCode(emailController.text, context);
    }
  }

  Future<void> _resetPassword() async {
    if (_resetFormKey.currentState!.validate()) {
      // Make API call to reset password using all four fields
      final reset = ResetPassModel(
          email: emailController.text,
          code: codeController.text,
          password: passController.text,
          confirmPassword: confirmpassController.text);

      DoctorApiService().resetPassword(reset, context);
    }
  }

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
      body: SingleChildScrollView(
        child: Column(
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
                      BorderRadius.only(bottomLeft: Radius.circular(42))
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Image.asset(
                  'assets/images/eye-scan.png',
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Forget Password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    'Enter your email to receive a code to reset your password',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Email Form
                  Form(
                    key: _emailFormKey,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        return FormValidation().emailVal(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _sendCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff485190),
                    ),
                    child: const Text(
                      'Send Code',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Reset Password Form
                  Form(
                    key: _resetFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: codeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Code",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            prefixIcon: Icon(Icons.numbers_rounded),
                          ),
                          validator: (value) {
                            return FormValidation()
                                .validateField(value, "Code");
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: passToggle,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  passToggle = !passToggle;
                                });
                              },
                              child: Icon(passToggle
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          validator: (value) {
                            return FormValidation().passwordVal(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: confirmpassController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: passToggle,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  passToggle = !passToggle;
                                });
                              },
                              child: Icon(passToggle
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            return FormValidation().passwordVal(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _resetPassword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff485190),
                              ),
                              child: const Text(
                                'Reset Password',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
