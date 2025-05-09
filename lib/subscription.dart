import 'package:flutter/material.dart';
import 'home_worker.dart';
import 'login.dart';
import 'payment.dart';



class SubscriptionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SubscriptionScreen(),
    );
  }
}

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String? selectedPlan; // Variable to store selected plan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Set background color to #f2f2f2

      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2), // Set background color to #f2f2f2

        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>MsharienaApp()),
            );


          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Subscription",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF75A488),
                fontFamily: "Inter",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Choose the plan that is right for you",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF213744),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              "Downgrade or Upgrade at anytime you want",
              style: TextStyle(
                color: Color(0xFF6E6E6E),
                fontFamily: "Inter",
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Remove all ads",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Inter",
                color: Color(0xFF213744),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),

            // Subscription Options
            buildPlanOption("1 Month", "\$5/monthly"),
            SizedBox(height: 8),
            buildPlanOption("3 Months", "\$13/3months"),
            SizedBox(height: 8),
            buildPlanOption("6 Months", "\$25/6months"),
            SizedBox(height: 8),
            buildPlanOption("1 Year", "\$50/yearly"),
            SizedBox(height: 30),

            // Subscribe Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4B5D69),
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: selectedPlan != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp5()),
                );                print("Subscribed to: $selectedPlan");
              }
                  : null, // Disable button if no plan selected
              child: Text(
                "Subscribe",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 5),

            // No, Thank You Option
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MsharienaApp()),
                );

              },
              child: Text(
                "No, Thank you",
                style: TextStyle(
                  color: Color(0xFF577965),
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for subscription plan option
  Widget buildPlanOption(String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(
          selectedPlan == title
              ? Icons.check_circle // Green checkmark when selected
              : Icons.radio_button_unchecked, // Grey circle when unselected
          color: selectedPlan == title ? Colors.green : Colors.grey,
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[700])),
        onTap: () {
          setState(() {
            selectedPlan = title;
          });
        },
      ),
    );
  }
}
