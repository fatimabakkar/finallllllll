import 'package:flutter/material.dart';
import 'dart:io';  // <-- Needed to check if the image path is a file
import 'notification worker.dart';
import 'chat.dart';
import 'profile.dart';
import "provider.dart";
import 'home_company.dart';
import 'project model.dart';
import 'package:provider/provider.dart';  // Import the Provider package

List<Post> posts = [];

void main() {
  runApp(MsharienaApp(

  ));
}

class MsharienaApp extends StatelessWidget {
  const MsharienaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider(
        create: (context) => ProjectProvider(), // Provide ProjectProvider
    child: const HomePage(), // Set the HomePage (Company page) as the root
    ),
    debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> filteredPosts = [];
  TextEditingController searchController = TextEditingController();
  List<Project> projects = []; // List to hold projects



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Mshari', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
            Text('عُ', style: TextStyle(color: Color(0xFF75A488), fontWeight: FontWeight.bold, fontSize: 24)),
            Text('na', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xff76A488)),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate(posts: posts));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Top Users', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF75A488))),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topUsers.length,
                itemBuilder: (context, index) {
                  final user = topUsers[index];
                  return SizedBox(
                    width: width * 0.4,
                    child: UserCard(name: user.name, role: user.role, image: user.image),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Text('Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF75A488))),
            ),

            // Display projects here
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ProjectCard(project: projects[index]);
              },
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              IconButton(
                icon: const Icon(Icons.home, size: 34, color: Color(0xFF75A488)),
                onPressed: () {
                  // Do nothing because you are already in home
                },
              ),
              IconButton(
                icon: const Icon(Icons.chat, size: 33, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp3()));
                },
              ),
              SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.notifications, size: 33, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsApp()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.person, size: 33, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}


// -------------------------
// UserItem model + user list
// -------------------------
class UserItem {
  final String name;
  final String role;
  final String image;

  UserItem(this.name, this.role, this.image);
}

List<UserItem> topUsers = [
  UserItem('Omar', 'construction worker', 'assets/omar.png'),
  UserItem('Ahmad', 'Electrician', 'assets/ahmad.png'),
  UserItem('Kariam', 'carpenter', 'assets/kariam.png'),
  UserItem('Nour', 'Designer', 'assets/nour.png'),
  UserItem('Tarek', 'Plumber', 'assets/tarek.png'),
  UserItem('Mariam', 'Developer', 'assets/mariam.png'),
  UserItem('Kahva and More', 'Top 1 company', 'assets/Screenshot 2025-03-20 220008.png'),
  UserItem('Eye zone Optic', 'Top 2 company', 'assets/Screenshot 2025-03-20 215116.png'),
  UserItem('Jaber Construction', 'Plumber', 'assets/jaberConstruction.jpeg'),
];

// -------------------------
// Project model + project list
// -------------------------
class Project {
  final String name;
  final String image;
  final String subtitle;

  Project(this.name, this.image, this.subtitle);

  @override
  String toString() {
    return 'Project{name: $name, image: $image, subtitle: $subtitle}';
  }
}


// -------------------------
// Post model + list of posts
// -------------------------
class Post {
  final String userName;
  final String userProfile;
  final String postImage;  // New property for post image
  final int rating;
  final String role;

  Post(this.userName, this.userProfile, this.postImage, this.rating, this.role);
}

// Default posts with both profile image and post image
// List<Post> posts = [
//   Post('kahve and More', 'assets/kahve.jpeg', 'assets/5coffe.png', 4, ''),
//   Post('kariam', 'assets/kariam.png', 'assets/post_image2.jpg', 4, 'carpenter'),
// ];

// -------------------------
// UserCard Widget
// -------------------------
class UserCard extends StatelessWidget {
  final String name;
  final String role;
  final String image;

  const UserCard({
    required this.name,
    required this.role,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 30,
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(role, style: const TextStyle(fontSize: 12, color: Color(0xFF75A488))),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 16),
              Icon(Icons.star, color: Colors.amber, size: 16),
              Icon(Icons.star, color: Colors.amber, size: 16),
              Icon(Icons.star, color: Colors.amber, size: 16),
              Icon(Icons.star, color: Colors.amber, size: 16),
            ],
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {},
            child: const Text(
              'View Profile',
              style: TextStyle(color: Color(0xff34566A)),  // Setting text color to green
            ),
          )
        ],
      ),
    );
  }
}

// -------------------------
// ProjectCard Widget
// -------------------------
class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              project.name,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            subtitle: Text(project.subtitle),
          ),
          Image.file(File(project.image)), // Display image dynamically
        ],
      ),
    );
  }
}

// -------------------------
// PostCard Widget
// -------------------------
class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isFile = File(post.postImage).existsSync();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(post.userProfile)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(post.rating, (index) => const Icon(Icons.star, color: Colors.amber, size: 16)),
                ),
                Text(post.role, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff76A488))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: isFile
                  ? Image.file(File(post.postImage), height: 300, width: double.infinity, fit: BoxFit.cover)
                  : Image.asset(post.postImage, height: 300, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------
// ProjectDetailsPage Widget
// -------------------------
class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          project.name,
          style: TextStyle(
            color: Color(0xFF75A488), // Green color for title
            fontWeight: FontWeight.bold, // Bold title
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Smaller image with rounded corners
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  project.image,
                  height: 200, // Smaller size for the image
                  width: 250, // Ensure image takes full width
                  fit: BoxFit.cover, // Ensure the image fits properly inside the container
                ),
              ),
            ),
            Center(
              child: Text(
                project.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Center the location with the icon
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centering the row
                children: [
                  Icon(
                    Icons.location_on, // Location icon
                    color: Color(0xFF75A488), // Green color for the icon
                    size: 20,
                  ),
                  const SizedBox(width: 8), // Space between the icon and the text
                  Text(
                    'Tripoli',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700], // Location text color
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Skill Needed Text
            Text(
              'Skill Needed: Construction Worker',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Budget Text
            Text(
              'Budget: 10\$ per hour',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Start Date Text
            Text(
              'Start Date: 10 January 2025',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            // End Date Text
            Text(
              'End Date: 5 September 2025',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 45),

            // About this project section
            Text(
              'About This Project:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF213744),
              ),
            ),
            const SizedBox(height: 8),

            // Rectangle for the project description
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background for description
                borderRadius: BorderRadius.circular(10), // Rounded corners
                border: Border.all(color: Colors.grey[400]!), // Border color
              ),
              child: Text(
                'We are planning to construct a ten-story building equipped with an elevator.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 53),

            // Apply Now button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the ApplyFormPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApplyFormPage(project: project),
                    ),
                  );
                },
                child: Text(
                  'Apply now',
                  style: TextStyle(
                    color: Color(0xff4B5D69), // Set text color to #4B5D69
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button background color (set to white for border contrast)
                  side: BorderSide(
                    color: Color(0xff4B5D69), // Border color
                    width: 2, // Border width
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CustomSearchDelegate extends SearchDelegate {
  final List<Post> posts;

  CustomSearchDelegate({required this.posts});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Container(
        color: const Color(0xFFF2F2F2), // Set the background color for the suggestions

        child: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';  // Clears the search query when the button is pressed
          },
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F2F2), // Set the background color for the suggestions

      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);  // Closes the search view
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = posts.where((post) {
      return post.userName.toLowerCase().contains(query.toLowerCase()) ||
          post.role.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Container(
      color: const Color(0xFFF2F2F2), // Set the background color for the search results
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final post = results[index];
          return ListTile(
            title: Text(post.userName),
            subtitle: Text(post.role),
            leading: CircleAvatar(
              backgroundImage: AssetImage(post.userProfile),
            ),
            trailing: Image.asset(post.postImage), // Display the post image
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = posts.where((post) {
      return post.userName.toLowerCase().contains(query.toLowerCase()) ||
          post.role.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Container(
      color: const Color(0xFFF2F2F2), // Set the background color for the suggestions
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final post = suggestions[index];
          return ListTile(
            title: Text(post.userName),
            subtitle: Text(post.role),
            leading: CircleAvatar(
              backgroundImage: AssetImage(post.userProfile),
            ),
            trailing: Image.asset(post.postImage), // Display the post image
          );
        },
      ),
    );
  }
}


class ApplyFormPage extends StatelessWidget {
  final Project project;

  // Create TextEditingController for the comment field
  final TextEditingController commentController = TextEditingController();

  ApplyFormPage({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Applying for ${project.name}\'s \n project',
          style: TextStyle(
            color: Color(0xFF75A488),
            fontSize: 20,
            fontFamily: "Inter", // Green color for title
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add CV section
            Text(
              'Add CV if you want',
              style: TextStyle(fontSize: 16, color: Color(0xff213744)),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                // Logic for selecting a file (CV)
                print("CV file added");
              },
              icon: Icon(Icons.upload_file),
              label: Text(
                "Add file",
                style: TextStyle(color: Color(0xFF75A488)), // Green text color
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Button background color
                side: BorderSide(
                  color: Color(0xFF75A488), // Green border color
                  width: 2, // Border width
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
              ),
            ),
            const SizedBox(height: 100),

            // Add comment section
            Text(
              'Add comment:',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: commentController, // Attach the controller to the TextField
              decoration: InputDecoration(
                hintText: 'Write here.....',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // Border radius set to 15
                ),
              ),
              maxLines: 13,
            ),
            const SizedBox(height: 20),

            // Send request button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logic to handle send request
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Your application has been successfully submitted'),
                  ));

                  // Clear the comment text field after submission
                  commentController.clear();
                },
                child: Text('Send request'),
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Color(0xff4B5D69), // Border color
                    width: 2, // Border width
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}