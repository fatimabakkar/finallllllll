import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Kahve And More";
  String email = "Kahveandmore@gmail.com";
  String phone = "78 654 987";

  String location = "Tripoli, Lebanon";
  String aboutMe = "Coffee shop\nFrom Roast To Frost\nMore than just coffee ☕\nSpecialty brews, frozen treats, & good vibes ✨";

  void _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          name: name,
          email: email,
          phone: phone,

          location: location,
          aboutMe: aboutMe,
        ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      print('Updated Data: $result');  // Add this log to see the result
      setState(() {
        name = result['name'] ?? name;
        email = result['email'] ?? email;
        phone = result['phone'] ?? phone;
        location = result['location'] ?? location;
        aboutMe = result['aboutMe'] ?? aboutMe;
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.grey),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF4B5D69),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/companyprofile.jpeg'),
                ),
              ),
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              RatingBarIndicator(
                rating: 5.0,
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
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Image.asset(
              'assets/companyprofile.jpeg',
              height: 140,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4B5D69))),
          const SizedBox(height: 4),
          RatingBarIndicator(
            rating: 5.0,
            itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
          const SizedBox(height: 4),
          Text("\u{1F4CD} $location", style: TextStyle(color: Color(0xFF4B5D69))),
          const Text("\u{1F517} Instagram", style: TextStyle(color: Color(0xFF8EADC1))),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _navigateToEditProfile,

                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9CAF88)),
                child: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9CAF88)),
                child: const Text("Share Profile", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Color(0xFF4B5D69),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Color(0xFF9CAF88),
                    tabs: [
                      Tab(text: "Posts"),
                      Tab(text: "Projects"),
                      Tab(text: "About Us"),
                      Tab(text: "Feedback"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _PostGallery(),
                        ListView(
                          padding: EdgeInsets.all(16),
                          children: [
                            _projectCard(
                              context,
                              title: name,
                              subtitle: "Coffee Shop Website",
                              role: "Developer",
                              imagePath: 'assets/companyproject.jpeg',
                            ),
                            const SizedBox(height: 12),
                            _projectCard(
                              context,
                              title: name,
                              subtitle: "Tables For Coffee Shop",
                              role: "Carpenter",
                              imagePath: 'assets/companyproject.jpeg',
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Card(
                            color: Color(0xFFF2F2F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(aboutMe),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Card(
                            color: Color(0xFFF2F2F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundImage: AssetImage('assets/carpenter.jpeg'),
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text("Khaled", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("Carpenter", style: TextStyle(fontSize: 12, color: Colors.grey))
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(Icons.more_vert, color: Colors.grey),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 16)),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Working with Kahve And More was such a good experience. They are really kind and treated me with a lot of respect. I would definitely work with them again",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  const Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text("2 days ago", style: TextStyle(color: Colors.green, fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
              IconButton(icon: const Icon(Icons.home, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.chat, color: Colors.white), onPressed: () {}),
              const SizedBox(width: 40),
              IconButton(icon: const Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.person, color: Color(0xFF9CAF88)), onPressed: () {}),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4B5D69),
        onPressed: () {},
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  static Widget _drawerItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 24),
        title: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
        onTap: () {},
      ),
    );
  }
}

Widget _projectCard(BuildContext context, {required String title, required String subtitle, required String role, required String imagePath}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            List<Map<String, dynamic>> applicants = [];

            if (subtitle == "Coffee Shop Website") {
              applicants = [
                {'name': 'Mariam', 'role': 'Developer', 'rating': 4.5, 'image': 'assets/mariam.jpeg'},
                {'name': 'Sara', 'role': 'Developer', 'rating': 5.0, 'image': 'assets/sara.jpeg'},
                {'name': 'Tina', 'role': 'Developer', 'rating': 4.8, 'image': 'assets/tina.jpeg'},
              ];
            } else if (subtitle == "Tables For Coffee Shop") {
              applicants = [
                {'name': 'Khaled', 'role': 'Carpenter', 'rating': 4.7, 'image': 'assets/khaled.jpeg'},
                {'name': 'Omar', 'role': 'Construction Worker', 'rating': 4.3, 'image': 'assets/omar.jpeg'},
              ];
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkerApplicantsScreen(
                  projectTitle: subtitle,
                  applicants: applicants,
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(role, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ],
    ),
  );
}

class _PostGallery extends StatelessWidget {
  const _PostGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/compamypost1.png',
      'assets/compamypost2.png',
      'assets/compamypost3.png',
      'assets/compamypost4.png',
      'assets/compamypost5.png',
      'assets/compamypost6.png',
      'assets/compamypost7.png',
      'assets/compamypost8.png',
      'assets/compamypost9.png',
      'assets/compamypost10.png',
      'assets/compamypost11.png',
      'assets/compamypost12.png',
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return Image.asset(imagePaths[index], fit: BoxFit.cover);
      },
    );
  }
}



class WorkerApplicantsScreen extends StatelessWidget {
  final String projectTitle;
  final List<Map<String, dynamic>> applicants;

  const WorkerApplicantsScreen({super.key, required this.projectTitle, required this.applicants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workers who applied to $projectTitle', style: const TextStyle(fontSize: 16, color: Colors.green)),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: applicants.length,
        itemBuilder: (context, index) {
          final applicant = applicants[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(applicant['image']),
              radius: 24,
            ),
            title: Text(applicant['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(applicant['role']),
                RatingBarIndicator(
                  rating: applicant['rating'],
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                  itemSize: 16,
                ),
                GestureDetector(
                  onTap: () {
                    // Check the applicant's name and navigate accordingly
                    if (applicant['name'] == 'Khaled') {
                     // Navigator.push(
                      //  context,
                       // MaterialPageRoute(builder: (context) => ProfileScreenKhaled()),
                     // );
                    } else if (applicant['name'] == 'Omar') {
                      //Navigator.push(
                     //   context,
                       // MaterialPageRoute(builder: (context) => ProfileScreenOmar()),
                      //);
                    }
                  },
                  child: const Text("See Profile", style: TextStyle(color: Colors.green)),
                ),

              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              if (applicant['name'] == 'Mariam') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MariamApplicationPage()),
                );
              }
              if (applicant['name'] == 'Khaled') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KhaledApplicationPage()),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class KhaledApplicationPage extends StatelessWidget {
  const KhaledApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Khaled's application for\nTable For Coffee Shop",
            style: TextStyle(color: Color(0xFF75A488), fontSize: 16), textAlign: TextAlign.center),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Add CV if you want",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.file_present, size: 18),
                  label: const Text("File Name"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFF2F2F2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text("Add comment", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                "I am available to do the tables you require and may be able to complete it ahead of schedule.",
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFE7F2EA),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text("Accept", style: TextStyle(color: Colors.black)),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3F3F3),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text("Decline", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
class MariamApplicationPage extends StatelessWidget {
  const MariamApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Mariam’s application for \n Coffee Shop Website",
            style: TextStyle(color: Color(0xFF75A488), fontSize: 16), textAlign: TextAlign.center),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Add CV if you want",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.file_present, size: 18),
                  label: const Text("File Name"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFF2F2F2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text("Add comment", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                "I am available to develop the website you require and may be able to complete it ahead of schedule.",
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFE7F2EA),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text("Accept", style: TextStyle(color: Colors.black)),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3F3F3),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text("Decline", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;

  final String location;
  final String aboutMe;

  const EditProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,

    required this.location,
    required this.aboutMe,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  late TextEditingController _locationController;
  late TextEditingController _aboutMeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);

    _locationController = TextEditingController(text: widget.location);
    _aboutMeController = TextEditingController(text: widget.aboutMe);
  }

  void _saveProfile() {
    Navigator.pop(context, {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'location': _locationController.text,
      'aboutMe': _aboutMeController.text,
    });
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
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/companyprofile.jpeg'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text("Edit picture", style: TextStyle(color: Color(0xFF75A488))),
            ),
            const SizedBox(height: 20),
            _buildTextField("Name", _nameController),
            _buildTextField("Email", _emailController),
            _buildTextField("Phone Number", _phoneController),

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

