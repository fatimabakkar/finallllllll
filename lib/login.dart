import 'package:flutter/material.dart';
//import 'package:senior2/subs_company.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:senior2/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';
import 'home_company.dart';
import 'home_worker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false; // Variable for Remember Me checkbox
  final TextEditingController usernameOremailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to handle login
// Function to handle login
  Future<void> loginUser() async {
    try {
      String userInput = usernameOremailController.text;
      String password = passwordController.text;

      Map<String, dynamic> bodyData = {
        'password': password,
      };

      if (userInput.contains('@')) {
        bodyData['email'] = userInput; // it's an email
      } else {
        bodyData['username'] = userInput; // it's a username
      }

      final response = await http.post(
        Uri.parse(Config.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        String userType = data['type'];
        String token = data['token'];
        String userId = data['userId']; // make sure your backend sends this

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('userId', userId);

        navigateBasedOnUserType(userType, token);

      } else {
        print('Login failed: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error logging in: $e');
    }
  }
  void navigateBasedOnUserType(String userType, String token) {
    if (userType == 'worker') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MsharienaApp()),
      );
    } else if (userType == 'company') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MsharienaApp2()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unknown user type')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo.jpeg',
              height: 40,
            ),
            const SizedBox(width: 5),
            const Text(
              'Mshari',
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
            const Text(
              'عُ',
              style: TextStyle(color: Color(0xFF75A488),
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
            const Text(
              'na',
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Login",
              style: TextStyle(fontSize: 24,
                  color: Color(0xFF75A488),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: usernameOremailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Username or Email",
                hintText: "Enter your username or email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xFF75A488)),
                  child: Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value!;
                      });
                    },
                    activeColor: const Color(0xFF75A488),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const Text(
                  "Remember me",
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6E6E6E)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  String username = usernameOremailController.text;
                  String email = usernameOremailController.text;
                  String password = passwordController.text;

                  if ((username.isNotEmpty || email.isNotEmpty) && password.isNotEmpty) {
                    loginUser();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter username/email and password'))
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B5D69),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Log In",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?", style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),);
                  },
                  child: const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 15,
                        color: Color(0xFF75A488),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

