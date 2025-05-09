// lib/config.dart
class Config {
  // Base URL for your backend
  static const String baseUrl = 'http://192.168.50.134:5000';

  //auth-related Routes
  static const String register = '$baseUrl/api/auth/register'; // Register worker route
  // Register company route
  static const String login = '$baseUrl/api/auth/login'; // Login route

  // Post-related Routes
  static const String AddPost = '$baseUrl/api/posts/add/';

  static const String otpResend ='$baseUrl/api/auth/resend-otp';
  static const String otpVerify ='$baseUrl/api/auth/verify-otp';
  static const String profile ='$baseUrl/api/auth/profile';
  static const String editprofile ='$baseUrl/api/worker/profile/';
}
