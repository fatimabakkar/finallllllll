import 'dart:io';
import 'notification worker.dart';
import 'chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';
import 'newlist.dart';
import "applay.dart";
import "add post.dart";
List<Post> posts = [];

void main() {
  runApp(

    ChangeNotifierProvider(
      create: (_) => ProjectProvider(),
      child:  P2Page(),


    ),
  );
}

class P2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the list of projects from the provider
    final projects = Provider.of<ProjectProvider>(context).projects;
    return MaterialApp(
      home: HomePage(),
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
  void initState() {
    super.initState();
    // Adding default posts
    posts.addAll([
      Post('kariam', 'assets/kariam.png', 'assets/njarpost.png', 4, 'carpenter', 'This a piece furniture I’m working on '),
      Post('Omar', 'assets/omar.png', 'assets/post omar.png', 3, 'construction worker', ''),
    ]);
    filteredPosts.addAll(posts);  // Initially set filtered posts to all posts
  }
  void addPost(Post post) {
    setState(() {
      posts.add(post);
      filteredPosts.add(post);  // Add new post to the filtered list too
    });
  }
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
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Top Users',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF75A488),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topUsers.length,
                itemBuilder: (context, index) {
                  final user = topUsers[index];
                  return SizedBox(
                    width: 150,
                    child: UserCard(
                      name: user.name,
                      role: user.role,
                      image: user.image,
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Text(
                'Company\'s/worker\'s Posts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF75A488),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return PostCard(post: post);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Text(
                'Project Cards',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF75A488),
                ),
              ),
            ),
            Consumer<ProjectProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: provider.projects.length,
                  itemBuilder: (context, index) {
                    final project = provider.projects[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          // The rest of the project content
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ListTile for the project title and subtitle
                              ListTile(
                                title: Text(project.name),
                                subtitle: Text(project.subtitle),
                              ),
                              project.image.isNotEmpty
                                  ? Image.file(
                                File(project.image),
                                width: double.infinity,
                                height: 400,
                                fit: BoxFit.cover,
                              )
                                  : Container(
                                width: double.infinity,
                                height: 400,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Arrow icon in the top-right corner
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                              onPressed: () {
                                // Navigate to the ProjectDetailPage
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) => ApplyProjectPage(project: project),
                                ),);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
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
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(color: Color(0xFF4B5D69), shape: BoxShape.circle),
        child: IconButton(
          icon: const Icon(Icons.add, size: 30, color: Colors.white),
          onPressed: () {
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => addpost()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4B5D69),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(" Add a Post", style: TextStyle(fontSize: 18)),
                      ),
                      SizedBox(height: 20),

                    ],
                  ),
                );
              },
            );
          },
        ),
      ),

    );
  }
}

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
];

// -------------------------
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
  final String text;

  Post(this.userName, this.userProfile, this.postImage, this.rating, this.role,this.text);
}

List<Post> posts2 = [
  Post('kariam', 'assets/kariam.png', 'assets/post_image2.jpg', 4, 'carpenter', 'This is a post about Kariam'),
  Post('Omar', 'assets/omar.png', 'assets/post_image2.jpg', 4, 'carpenter', 'This is a post about Omar'),
];

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
