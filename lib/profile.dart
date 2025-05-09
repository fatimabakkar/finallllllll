
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'config.dart';
import 'home_worker.dart';
import 'chat.dart';
import 'notification worker.dart';
import 'add postworker.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For token/userId
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String email = "";
  String job = "";
  String location = "";
  String aboutMe = "";
  String? profileImageUrl;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId == null) throw Exception("User not logged in");

      final response = await http.post(
        Uri.parse(Config.profile),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          name = data['name'] ?? '';
          email = data['email'] ?? '';
          job = data['job'] ?? '';
          location = data['location'] ?? '';
          aboutMe = data['aboutMe'] ?? '';
          profileImageUrl = data['profilePicture']?['url'];
          isLoading = false;
        });
      } else {
        throw Exception("Server error: ${response.body}");
      }
    } catch (e, stacktrace) {
      print("Fetch profile failed:");
      print(e);
      print(stacktrace);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading profile")),
      );
    }

  }


  void _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          name: name,
          email: email,
          job: job,
          location: location,
          aboutMe: aboutMe,
        ),
      ),
    );

    if (result != null && result['refresh'] == true) {
      // Re-fetch from backend
      fetchUserProfile();
    }
  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF4B5D69),
          child: Column(
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 40,
                backgroundImage: profileImageUrl != null
                    ? NetworkImage(profileImageUrl!)
                    : const AssetImage('assets/khaled.png') as ImageProvider,              ),
              Text(
                name,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              RatingBarIndicator(
                rating: 4.0,
                itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 16.0,
                direction: Axis.horizontal,
              ),
              const Divider(color: Colors.grey, thickness: 0.5, indent: 20, endIndent: 20),
              const SizedBox(height: 10),
              _drawerItem(Icons.settings, "Settings"),
              _drawerItem(Icons.bookmark_border, "Saved"),
              _drawerItem(Icons.subscriptions, "Subscription"),
              _drawerItem(Icons.flag_outlined, "Report a problem"),
              _drawerItem(Icons.help_outline, "Help & support"),
              _drawerItem(Icons.info_outline, "Terms and policies"),
              const Spacer(),
              const Divider(color: Colors.grey, thickness: 0.5, indent: 20, endIndent: 20),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.grey),
                title: const Text("Log out", style: TextStyle(color: Colors.grey)),
                onTap: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/khaled.png'),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          RatingBarIndicator(
            rating: 4.0,
            itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
          const SizedBox(height: 4),
          Text(job, style: const TextStyle(fontSize: 16, color: Color(0xFF75A488))),
          Text("\u{1F4CD} $location", style: const TextStyle(color: Color(0xFF4B5D69))),
          Text("\u{1F517} Facebook", style: const TextStyle(color: Color(0xFF8EADC1))),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _navigateToEditProfile,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF75A488)),
                child: const Text("Edit profile", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF75A488)),
                child: const Text("Share profile", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.black,
                    tabs: [
                      Tab(text: "Posts"),
                      Tab(text: "About me"),
                      Tab(text: "Feedback"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        GridView.builder(
                          padding: const EdgeInsets.all(10),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            List<String> imagePaths = [
                              'assets/chaire.jpeg',
                              'assets/chaire2.jpeg',
                              'assets/table.jpeg',
                              'assets/table2.jpeg',
                              'assets/table3.jpeg',
                              'assets/table4.jpeg',
                              'assets/table5.jpeg',
                              'assets/workshop.jpeg',
                            ];
                            return Image.asset(imagePaths[index], fit: BoxFit.cover);
                          },
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                color: const Color(0xFFD9D9D9),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(aboutMe, style: const TextStyle(fontSize: 14)),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text("Skills", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: const [
                                  Chip(label: Text("carpenter")),
                                  Chip(label: Text("Painter")),
                                ],
                              ),
                              const Text("Company's Worked with", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 8),
                              Card(
                                color: const Color(0xFFD9D9D9),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundImage: AssetImage('assets/eye.png'),
                                                radius: 16,
                                              ),
                                              const SizedBox(width: 10),
                                              const Text("Eye Zone Optic", style: TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          ),

                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 16)),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Card(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            backgroundImage: AssetImage('assets/eye.png'),
                                            radius: 16,
                                          ),
                                          const SizedBox(width: 10),
                                          const Text("Eye Zone Optic", style: TextStyle(fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      const Icon(Icons.more_vert),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 16)),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Khaled is one of the best workers I’ve worked with so far. I’d definitely recommend him to anyone who wants to hire a carpenter",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 10),
                                  const Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text("2 days ago", style: TextStyle(color: Colors.green, fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
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
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF4B5D69),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: const Icon(Icons.home, size: 34, color: Colors.white), onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MsharienaApp()),
              ); }),
              IconButton(icon: const Icon(Icons.chat, size: 33, color: Colors.white), onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (MyApp3())),
              );}),
              const SizedBox(width: 40),
              IconButton(icon: const Icon(Icons.notifications, size: 33, color: Colors.white), onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (NotificationsApp())),
              );}),
              IconButton(icon: const Icon(Icons.person, size: 33, color: Color(0xFF75A488)), onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (ProfileScreen())),
              );}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(text, style: const TextStyle(color: Colors.white)),
        onTap: () {},
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String job;
  final String location;
  final String aboutMe;

  const EditProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.job,
    required this.location,
    required this.aboutMe,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}
class _EditProfileScreenState extends State<EditProfileScreen> {

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _jobController;
  late TextEditingController _locationController;
  late TextEditingController _aboutMeController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _jobController = TextEditingController(text: widget.job);
    _locationController = TextEditingController(text: widget.location);
    _aboutMeController = TextEditingController(text: widget.aboutMe);
  }
  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    final uri = Uri.parse('${Config.editprofile}$userId');
    print('🚀 PUT URL: ${uri.toString()}'); // Add this line

    final request = http.MultipartRequest('PUT', uri);

    // Form fields
    request.fields['location'] = _locationController.text;
    request.fields['job'] = _jobController.text;
    request.fields['aboutMe'] = _aboutMeController.text;

    // Optional: attach image
    if (_selectedImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('photo', _selectedImage!.path),
      );
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      Navigator.pop(context, {
        'location': _locationController.text,
        'aboutMe': _aboutMeController.text,
        'job': _jobController.text,
        'refresh' : true
      });
    } else {
      print(await response.stream.bytesToString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text("Save", style: TextStyle(color: Color(0xFF75A488))),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : const AssetImage('assets/khaled.png') as ImageProvider,
                  ),
                  TextButton(
                    onPressed: _pickImage,
                    child: const Text("Edit picture", style: TextStyle(color: Color(0xFF75A488))),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            _buildTextField("Name", _nameController),
            _buildTextField("Email", _emailController),
            _buildTextField("Job", _jobController),
            _buildTextField("Location", _locationController),
            const SizedBox(height: 12),
            const Text("About Me", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _aboutMeController,
              maxLines: 4,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFF1F1F1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
                hintText: "Write about your experience...",
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF1F1F1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
