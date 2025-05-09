import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'profile.dart';
import 'home_company.dart';
import 'notification_company.dart';
import 'AddProject.dart';
import 'add post.dart';



class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MessagesPage(),
    );
  }
}

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  // List of message data
  final List<Map<String, String>> messages = [
    {"name": "Tarek", "message": "What time should i come over today?", "time": "5 min ago", "image": "assets/tarek.png", "new": "true"},
    {"name": "Ahmad", "message": "You: We are seeking your expertise to contribute to an upcoming project. Please let us know if you are interested", "time": "2h ago", "image": "assets/ahmad.png", "new": "false"},
    {"name": "Tina", "message": "You: hi how are you?", "time": "5h ago", "image": "assets/tina.png", "new": "false"},
    {"name": "Eye Zone Optic", "message": "You: sent a post", "time": "3 days ago", "image": "assets/Screenshot 2025-03-20 215116.png", "new": "false"},
  ];

  List<Map<String, String>> filteredMessages = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMessages.addAll(messages); // Initialize filteredMessages with all messages
  }

  // Function to filter messages based on the search query
  void filterMessages(String query) {
    final filtered = messages.where((message) {
      return message["name"]!.toLowerCase().contains(query.toLowerCase()) ||
          message["message"]!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredMessages = filtered; // Update the filteredMessages list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Set the background color to #f2f2f2

      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2), // Set the background color to #f2f2f2

        title: Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff76A488)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color(0xff4B5D69),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: searchController,
                onChanged: filterMessages, // Call filterMessages when the input changes
                style: TextStyle(color: Colors.white), // White text color for the search input
                decoration: InputDecoration(
                  hintText: 'Search.....',
                  hintStyle: TextStyle(color: Colors.white), // Lighter color for the hint text
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Messages List
            Expanded(
              child: ListView.builder(
                itemCount: filteredMessages.length,
                itemBuilder: (context, index) {
                  bool isNewMessage = filteredMessages[index]["new"] == "true"; // Check if the message is new
                  return ListTile(
                    leading: Stack(
                      clipBehavior: Clip.none, // Allow overflow for the green dot
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(filteredMessages[index]["image"]!),
                        ),
                        if (isNewMessage) Positioned(
                          left: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: Colors.green, // Green dot for new messages
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      filteredMessages[index]["name"]!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(filteredMessages[index]["message"]!),
                    trailing: Text(
                      filteredMessages[index]["time"]!,
                      style: TextStyle(color: Colors.green), // Green color for time
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    onTap: () {
                      // Navigate to the chat screen with the selected user (Mariam)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(user: filteredMessages[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
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
              IconButton(icon: Icon(Icons.home,size:34, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MsharienaApp2()),
                    );
                  }),
              IconButton(icon: Icon(Icons.chat,size:33, color: Color(0xFF75A488)), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MyApp2()),
                );
              }),
              SizedBox(width: 40),
              IconButton(icon: Icon(Icons.notifications,size:33,color: Colors.white ), onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsApp2() ),
                );
              }),
              IconButton(icon: Icon(Icons.person, size:33,color:Colors.white), onPressed: () {
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

class ChatScreen extends StatefulWidget {
  final Map<String, String> user;

  ChatScreen({required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  bool _isFileSelected = false; // To track if a file is selected
  String _selectedFile = ''; // Store the selected file path

  final ImagePicker _picker = ImagePicker();
  File? _image;

  // List to store the messages
  List<Map<String, String>> messages = [];

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store the image file
      });
    }
  }

  // Function to send a message
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        // Add the new message to the list with the sender as "Me"
        messages.add({
          "message": _controller.text,
          "time": "Just now",
          "name": "Me", // The sender's name is set to "Me"
          "image": "assets/ahmad.png", // You can replace this with your own user image if needed
        });

        // Clear the input field after sending the message
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user["name"]!),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Pop the current screen and return to the previous screen
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            // Display Project Image
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),

            // Divider

            // Message Section
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(messages[index]["image"]!),
                    ),
                    title: Text(messages[index]["name"]!), // "Me" for the sender
                    subtitle: Text(messages[index]["message"]!),
                    trailing: Text(
                      messages[index]["time"]!,
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),

            // Input Field and File Upload with Mic and Send Icons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Left side for text input or file upload
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.attach_file, color: Colors.grey), // File upload icon
                          onPressed: _pickImage, // Pick image when pressed
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type your message...",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right side for mic and send buttons
                  IconButton(
                    icon: Icon(Icons.mic, color: Colors.grey),
                    onPressed: () {
                      // Handle voice message (optional)
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.grey),
                    onPressed: _sendMessage, // Send the message when pressed
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
