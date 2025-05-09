import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
import 'verfiy.dart'; // Your OTP screen
import 'login.dart'; // Your login page

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController jobController = TextEditingController(); // extra field for Worker

  String? accountType = "worker"; // Default selected
  bool isLoading = false;

  void registerUser() async {
    if (nameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        (accountType == "worker" && jobController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    var regBody = {
      "username": usernameController.text,
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "type": accountType,
      if (accountType == "worker") "job": jobController.text,
    };

    setState(() {
      isLoading = true;
    });

    try {
      FocusScope.of(context).unfocus(); // 🚀 Move it after loading spinner showing
      var response = await http.post(
        Uri.parse(Config.register),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully")),
        );
        Navigator.pushReplacement(  // 🚀 Better to pushReplacement so user can't go back
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationPage(email: emailController.text),
          ),
        );
      } else {
        String errorMessage = "Registration failed.";
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (_) {}
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Network error. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 50,
                  width: 50,

                ),
                const SizedBox(width: 8),
                Flexible(  // <-- This fixes overflow
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Mshari', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                        const TextSpan(text: 'عُ', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF75A488))),
                        const TextSpan(text: 'na', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis, // prevent text overflow
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Create Account",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xFF75A488)),
            ),
            const SizedBox(height: 20),

            // Account Type Selection
            RadioListTile<String>(
              title: const Text('Worker'),
              value: "worker",
              groupValue: accountType,
              onChanged: (value) {
                setState(() {
                  accountType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Company'),
              value: "company",
              groupValue: accountType,
              onChanged: (value) {
                setState(() {
                  accountType = value;
                });
              },
            ),
            const SizedBox(height: 10),

            buildInputField(nameController, "Name"),
            const SizedBox(height: 20),
            buildInputField(usernameController, "Username"),
            const SizedBox(height: 20),
            buildInputField(emailController, "Email Address"),
            const SizedBox(height: 20),

            if (accountType == "worker") ...[
              buildInputField(jobController, "Job"),
              const SizedBox(height: 20),
            ],

            buildInputField(passwordController, "Password", isPassword: true),
            const SizedBox(height: 20),
            buildInputField(confirmPasswordController, "Confirm Password", isPassword: true),
            const SizedBox(height: 40),

            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B5D69),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: registerUser,
              child: const Text(
                "Create account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),


            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');

                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 15, color: Color(0xFF75A488), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String hintText, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}