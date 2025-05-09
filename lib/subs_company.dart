import 'package:flutter/material.dart';
import 'home_company.dart';
import 'paymentcompany.dart';

class SubscriptionApp2 extends StatelessWidget {
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
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            // Close action or back to previous screen if needed
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

            // Subscription Options
            buildPlanOption("1 Month", "\$10/monthly"),
            SizedBox(height: 8),
            buildPlanOption("3 Months", "\$25/3months"),
            SizedBox(height: 8),
            buildPlanOption("6 Months", "\$50/6months"),
            SizedBox(height: 8),
            buildPlanOption("1 Year", "\$99.99/yearly"),
            SizedBox(height: 30),

            // Subscribe Button (only enabled if a plan is selected)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4B5D69),
                padding: EdgeInsets.symmetric(vertical: 15), // Made the button smaller
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 45),
              ),
              onPressed: selectedPlan != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>paymantcompany()),
                );
                print("Subscribed to: $selectedPlan");
              }
                  : null, // Disable button if no plan selected
              child: Text(
                "Subscribe",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Start your 2 free weeks trial button (colored without needing a plan selection)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4B5D69),
                padding: EdgeInsets.symmetric(vertical: 15), // Made the button smaller
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 45),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>MsharienaApp2()),
                );
              },
              child: Text(
                "Start your 2 free weeks trial",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
