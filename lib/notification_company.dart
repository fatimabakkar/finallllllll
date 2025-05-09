import 'package:flutter/material.dart';
import 'kahve_project_page.dart'; // Import the second page
import 'home_company.dart';
import 'chat_company.dart';
import 'profile_company.dart';
import 'AddProject.dart';
import 'add post.dart';



class NotificationsApp2 extends StatelessWidget {
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
      "logo": "assets/mariam.png",
      "title": "Mariam applied to your Coffee Shop Website project.",
      "time": "6h ago"
    },
    {
      "logo": "assets/kariam.png",
      "title": "Karim added a new post.",
      "time": "1 day ago",
      //"route": "kahve_project"
    },
    {
      "logo": "assets/khaled.png",
      "title": "Khaled applied to your Table For Coffee Shop project.",
      "time": "3 days ago"
    },
    {
      "logo": "assets/omar.png",
      "title": "Omar added a new post. ",
      "time": "3 days ago"
    },
    {
      "logo": "assets/tina.png",
      "title": "tina applied to your project. ",
      "time": "1 days ago"
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Set the background color to #f2f2f2
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2), // Set the background color to #f2f2f2

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
              IconButton(icon: Icon(Icons.home, size:34,color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MsharienaApp2()),
                    );
                  }),
              IconButton(icon: Icon(Icons.chat,size:33, color: Colors.white), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MyApp2()),
                );
              }),
              SizedBox(width: 40),
              IconButton(icon: Icon(Icons.notifications,size:33, color: Color(0xFF75A488)), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  NotificationsApp2()),
                );
              }),
              IconButton(icon: Icon(Icons.person,size:33, color: Colors.white), onPressed: () {
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
            // Show a Dialog with options when the FAB is pressed
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Post Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  addpost()),
                          );
                          print('Post option selected');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4B5D69),
                          foregroundColor: Colors.white, // Text color white
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(" Add a Post", style: TextStyle(fontSize: 18)),
                      ),
                      SizedBox(height: 20),
                      // Project Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  PostPage()),
                          );
                          print('Project option selected');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4B5D69),
                          foregroundColor: Colors.white, // Text color white
                          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text("Add a Project", style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
