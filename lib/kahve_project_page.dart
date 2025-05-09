import 'package:flutter/material.dart';


class KahveProjectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KahveProjectPage(),
    );
  }
}

class KahveProjectPage extends StatefulWidget {
  @override
  _KahveProjectPageState createState() => _KahveProjectPageState();
}

class _KahveProjectPageState extends State<KahveProjectPage> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Kahve And More",
          style: TextStyle(
            color: Color(0xFF76A488),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/kahve2.jpeg",
                  height: 200,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tables For Coffee Shop",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      isBookmarked = !isBookmarked;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Color(0xFF76A488), size: 16),
                SizedBox(width: 5),
                Text("Tripoli", style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Skill Needed: Carpenter", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  Text("Budget: The budget will be decided later on", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  Text("Start Date: As soon as possible", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  Text("End Date: Before February", style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            SizedBox(height: 15),
            Text(
              "About This Project",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "I want to hire a carpenter to add tables to my coffee shop as soon as possible.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Message",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
