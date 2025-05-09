import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io'; // Import to handle images from the file system
import 'home_company.dart';
void main() {
  runApp(addpost());
}
class  addpost extends StatelessWidget {
  const addpost({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PostPage7(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PostPage7 extends StatefulWidget {
  const PostPage7({super.key});

  @override
  State<PostPage7> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage7> {
  File? _image; // Variable to store the selected image
  TextEditingController captionController = TextEditingController(); // Controller for the caption

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery); // Open gallery

    if (image != null) {
      setState(() {
        _image = File(image.path); // Update the image state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Set the background color to #f2f2f2
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2), // Set color for the app bar

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  MsharienaApp2()),
            ); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title "Add Post" above the image picker
              Center(
                child: const Text(
                  "Add Post",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF75A488),
                  ),
                ),
              ),
              const SizedBox(height: 100),

              // Image Picker Section
              GestureDetector(
                onTap: _pickImage, // Call _pickImage function when tapped
                child: Center(
                  child: Container(
                    width: 274,
                    height: 200,
                    color: Colors.grey[500],
                    child: _image == null
                        ? const Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 40,
                      ),
                    ) // If no image selected, show camera icon
                        : Image.file(
                      _image!, // Display selected image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10), // Add space between image picker and text

              // Text below the picture picker
              const Center(
                child: Text(
                  'Add a picture',
                  style: TextStyle(color: Color(0xFF75A488), fontSize: 16),
                ),
              ),
              const SizedBox(height: 30),

              // Caption Text Field with Character Counter
              TextFormField(
                controller: captionController,
                maxLength: 150, // Limit the caption to 150 characters
                decoration: InputDecoration(
                  hintText: 'Add caption...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), // Border radius of 15
                  ),                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 10),
              // Character Counter
              Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  color: captionController.text.length > 150
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
              const SizedBox(height: 20),

              // Post Button as a TextButton


              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4B5D69),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  Post pst = Post("userName", "userProfile", "postImage", 4, "role", "postText");
                  print('00000000000');
                  // posts.add(pst);
                  // print('1111111');
                  Navigator.pop(context, pst);
                  print('222222222');
                  // // Handle Post functionality (you can replace this with your backend logic)
                  // // print("Post Submitted with caption: ${captionController.text}");
                  // // if (_image != null && captionController.text.isNotEmpty) {
                  // //   // Add your post submission logic here
                  // //   print("Image uploaded and caption added");
                  // // } else {
                  // //   // Show an error message if no image or caption is provided
                  // //   print("Please add an image and a caption.");
                  // // }
                },
                child: Text(
                  "post",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}