import 'package:flutter/material.dart';
import 'home_company.dart';

class paymantcompany extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _saveCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Set the background color to #f2f2f2

      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2), // Set the background color to #f2f2f2

        title: Text(
          'Payment',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(

        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SizedBox(height: 90),

              // Card Holder Name
              TextField(
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),

              // Card Number with images on the right side
              TextField(
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                  // Images on the right side of the input field
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/Screenshot 2025-03-20 003123.png',  // Visa Image
                          height: 24,
                        ),
                        SizedBox(width: 8),
                        Image.asset(
                          'assets/Screenshot 2025-03-19 234428.png', // MasterCard Image
                          height: 24,
                        ),
                        SizedBox(width: 8),
                        Image.asset(
                          'assets/Screenshot 2025-03-19 234647.png',  // AMEX Image
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15),

              // Expiration Date (MM/YY)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'MM/YY',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Save Card Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _saveCard,
                    onChanged: (bool? value) {
                      setState(() {
                        _saveCard = value!;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                  Text(
                    'Save my card for faster checkout',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff6E6E6E),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Terms and Service link
              Text(
                'By clicking on the button you confirm to have accepted ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' Terms of Service',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff4B7C99),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),

              // PAY Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MsharienaApp2()),
                    );                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4B5D69), // Dark gray background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'PAY ..........USD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
