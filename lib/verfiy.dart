import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:senior2/config.dart';
import 'package:senior2/login.dart';

import 'config.dart';

// ✅ This function sends the OTP verification request
Future<void> verifyOtp(String email, String otp, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(Config.otpVerify), // <-- Replace with your server URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email verified successfully!'))
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP, please try again.'))
      );
    }
  } catch (e) {
    print('Error verifying OTP: $e');
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Server error, please try again later.'))
    );
  }
}

Future<void> resendOtp(String email, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(Config.otpResend), // <-- you need to make this API also in backend
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP resent successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to resend OTP.')),
      );
    }
  } catch (e) {
    print('Error resending OTP: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Server error. Try again later.')),
    );
  }
}

class OTPVerificationPage extends StatefulWidget {
  final String email; // ✅ Receive email


  const OTPVerificationPage({Key? key, required this.email}) : super(key: key);

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  List<TextEditingController> otpController = List.generate(4, (index) => TextEditingController());
  bool isLoading = false;
  bool canResend = true;
  int resendTimer = 30;
  void startResendTimer() {
    setState(() {
      canResend = false;
      resendTimer = 30;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (resendTimer == 0) {
        setState(() {
          canResend = true;
        });
        return false;
      } else {
        setState(() {
          resendTimer--;
        });
        return true;
      }
    });
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
            Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 50,
                  width: 50,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Mshari', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                        const TextSpan(text: 'عُ', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF75A488))),
                        const TextSpan(text: 'na', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            const Text(
              "Email Verification",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF75A488)),
            ),
            const SizedBox(height: 10),
            const Text(
              "We sent a code to your email. Please enter it below to verify.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 60,
                  child: TextField(
                    controller: otpController[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF75A488)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4B5D69), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) async {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }

                      // ✅ Check if all 4 fields are filled
                      String otp = otpController.map((controller) => controller.text).join();
                      if (otp.length == 4) {
                        setState(() {
                          isLoading = true;
                        });
                        await verifyOtp(widget.email, otp, context);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },

                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B5D69),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                String otp = otpController.map((controller) => controller.text).join();
                if (otp.length == 4) {
                  setState(() {
                    isLoading = true;
                  });
                  await verifyOtp(widget.email, otp, context);
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter the full 4-digit code"))
                  );
                }
              },
              child: const Text('Verify'),
            ),

            const SizedBox(height: 20),
            TextButton(
              onPressed: canResend ? () {
                resendOtp(widget.email, context);
                startResendTimer();
              } : null,
              child: Text(
                canResend ? "Resend Code" : "Wait ($resendTimer)",
                style: const TextStyle(fontSize: 16, color: Color(0xFF75A488)),
              ),
            ),

          ],
        ),
      ),
    );
  }
}