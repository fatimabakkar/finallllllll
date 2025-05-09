import 'package:flutter/material.dart';
import 'kahve_project_page.dart'; // Import the second page
import 'chat.dart';
import 'profile.dart';
import 'home_worker.dart';
import 'add postworker.dart';


class NotificationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificationsScreen(),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      "logo": "assets/jaberConstruction.jpeg",
      "title": "Jaber Construction declined your application on Building A House.",
      "time": "20 min ago"
    },
    {
      "logo": "assets/kahve.jpeg",
      "title": "Kahve And More accepted your application on Tables for Coffee Shop.",
      "time": "1 day ago",
      "route": "kahve_project"
    },
    {
      "logo": "assets/eye.png",
      "title": "Eye Zone Optic added a feedback to your profile",
      "time": "2 days ago"
    },
    {
      "logo": "assets/othmanConstrution.png",
      "title": "OTHMAN Construction name added a new project.",
      "time": "5 days ago"
    },
    {
      "logo": "assets/jaberConstruction.jpeg",
      "title": "Jaber Construction added a new project that might interest you.",
      "time": "5 days ago"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Set background color to #f2f2f2

      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2), // Set background color to #f2f2f2

        title: Text(
          "Notifications",
          style: TextStyle(
            color: Color(0xFF75A488),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(10),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(notifications[index]["logo"]!),
              backgroundColor: Colors.grey[200],
            ),
            title: Text(
              notifications[index]["title"]!,
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              notifications[index]["time"]!,
              style: TextStyle(color: Color(0xff76A488),fontWeight: FontWeight.bold),
            ),
            onTap: () {
              if (notifications[index]["title"]!.contains("Kahve And More")) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KahveProjectPage(),
                  ),
                );
              }
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF4B5D69),
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(Icons.home, size: 34,color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MsharienaApp()),
                    );
                  }),
              IconButton(icon: Icon(Icons.chat,size: 33, color: Colors.white), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MyApp3()),
                );
              }),
              SizedBox(width: 40),
              IconButton(icon: Icon(Icons.notifications,size: 33, color: Color(0xFF75A488)), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  NotificationsApp()),
                );
              }),
              IconButton(icon: Icon(Icons.person,size: 33, color: Colors.white), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 60, // Width of the button (double the radius)
        height: 60, // Height of the button (double the radius)
        decoration: BoxDecoration(
          color: Color(0xFF4B5D69), // Button color
          shape: BoxShape.circle, // Makes the container circular
        ),
        child: IconButton(
          icon: const Icon(Icons.add, size: 30, color: Colors.white), // + icon
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AddPost2()),
            );
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}
