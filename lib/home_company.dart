import 'package:flutter/material.dart';
import 'notification_company.dart';
import 'chat_company.dart';
import 'add post.dart';
import 'AddProject.dart';
import 'home_worker.dart';

void main() {
  runApp(MsharienaApp2());
}



class MsharienaApp2 extends StatelessWidget {
  const MsharienaApp2({super.key});

  @override
  Widget build(BuildContext context) {
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
  // A list to store posts dynamically
  List<Post> posts = [];
  List<Post> filteredPosts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Adding default posts
    posts.addAll([
      Post('kariam', 'assets/kariam.png', 'assets/njarpost.png', 4, 'carpenter', 'This a piece furniture I’m working on '),
      Post('Omar', 'assets/omar.png', 'assets/post omar.png', 3, 'construction worker', ''),
      Post('Sara', 'assets/Screenshot 2025-04-12 235811.png', 'assets/sarapost.png', 3, 'UI/UX designer', 'This is an app I recently designed '),
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
      backgroundColor: const Color(0xFFF2F2F2), // Set the background color to #f2f2f2

      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2), // Set color for the app bar

        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Mshari',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'عُ',
              style: TextStyle(
                color: Color(0xFF75A488),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'na',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          // Search icon in the top-right corner
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xff76A488)),
            onPressed: () {
              //   showSearch(context: context, delegate: CustomSearchDelegate(posts: posts));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Users Section with no background color, it will remain white
            Padding(
              padding: const EdgeInsets.all(12.0),
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
                    width: width * 0.4,
                    child: UserCard(
                      name: user.name,
                      role: user.role,
                      image: user.image,
                    ),
                  );
                },
              ),
            ),

            // Posts Section (User can add posts)
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

            // Display user posts vertically
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredPosts.length,  // Display the number of filtered posts
              itemBuilder: (context, index) {
                final post = filteredPosts[index];  // Get the filtered post data
                return PostCard(post: post);  // Pass the post to PostCard widget
              },
            ),
          ],
        ),
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
              IconButton(
                icon: const Icon(Icons.home,size: 34, color:  Color(0xFF75A488)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MsharienaApp2()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.chat,size: 33, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MyApp2()),
                  );
                },
              ),
              SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.notifications,size: 33, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MsharienaApp()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.person,size: 33, color: Colors.white),
                onPressed: () {

                },
              ),
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
  UserItem('Jaber Construction', 'Top 3 company', 'assets/jaberConstruction.jpeg'),
];

// -------------------------
// Post model + list of posts
// -------------------------
class Post {
  final String userName;
  final String userProfile;
  final String postImage;  // New property for post image
  final int rating;
  final String role;
  final String postText; // Added attribute for post text

  Post(this.userName, this.userProfile, this.postImage, this.rating, this.role, this.postText);
}

// Default posts with both profile image and post image
List<Post> posts = [
  Post('kariam', 'assets/kariam.png', 'assets/post_image2.jpg', 4, 'carpenter', 'This is a post about Kariam'),
  Post('Omar', 'assets/omar.png', 'assets/post_image2.jpg', 4, 'carpenter', 'This is a post about Omar'),
  Post('kahve and More', 'assets/kahve.jpeg', 'assets/5coffe.png', 4, '', 'This is a post about Kahve and More'),
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

// -------------------------
// PostCard Widget
// -------------------------
class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white, // Set the background color to white
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(post.userProfile),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // Center the rating stars
                  children: List.generate(post.rating, (index) {
                    return const Icon(Icons.star, color: Colors.amber, size: 16);
                  }),
                ),
                Text(
                  post.role,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff76A488)),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onPressed: () {
                // Navigate to user profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfileScreen(userName: post.userName)),
                );
              },
            ),
          ),
          // Display the post image (larger image)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12), // Rounded corners
              child: Image.asset(
                post.postImage,
                height: 300,  // Increased the image size
                width: double.infinity,  // Make the image take full width of the container
                fit: BoxFit.cover,  // Ensure the image covers the area properly
              ),
            ),
          ),
          // Display post text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              post.postText,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  final String userName;

  const UserProfileScreen({required this.userName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Center(
        child: Text('User Profile for $userName'),
      ),
    );
  }
}