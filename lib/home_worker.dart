import 'package:flutter/material.dart';
import 'dart:io';  // <-- Needed to check if the image path is a file
import 'notification worker.dart';
import 'chat.dart';
import 'profile.dart';
import 'project model.dart';
import 'package:provider/provider.dart';  // Import the Provider package
import "provider.dart";
import "newlist.dart";


List<Post> posts = [];

void main() {
  runApp(
       MsharienaApp(),

  );
}

class MsharienaApp extends StatelessWidget {
  const MsharienaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<ProjectProvider>(context).projects;

    return MaterialApp(
      home: const HomePage(),
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
          children: const [
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
            ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return Card(
                  child: ListTile(
                    title: Text(project.name),
                    subtitle: Text(project.subtitle),
                    leading: project.image.isNotEmpty
                        ? Image.file(
                      File(project.image),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                //return ProjectCard(project: projects[index]);
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
                onPressed: () {},
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

