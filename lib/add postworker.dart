import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'config.dart';

// 🚀 FIXED: Class names must be PascalCase
class AddPost2 extends StatelessWidget {
  const AddPost2({super.key});

  @override
  Widget build(BuildContext context) {
    return const PostPage3(); // Return PostPage (no MaterialApp here)
  }
}

class PostPage3 extends StatefulWidget {
  const PostPage3({super.key});

  @override
  State<PostPage3> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage3> {
  File? _image;
  TextEditingController captionController = TextEditingController();

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
  Future<void> _savePost() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    final uri = Uri.parse('${Config.baseUrl}/api/post/add/$userId'); // adjust base URL if needed

    final request = http.MultipartRequest('POST', uri);
    request.fields['caption'] = captionController.text;

    if (_image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('PostImage', _image!.path),
      );
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      final resBody = await response.stream.bytesToString();
      print(resBody);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to post')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Only pop
          },
        ),
        elevation: 0, // 🚀 FIXED: better UI
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Add Post",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF75A488),
                  ),
                ),
              ),
              const SizedBox(height: 50), // 🚀 FIXED: better spacing

              GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: Container(
                    width: 274,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _image == null
                        ? const Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 40,
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  'Add a picture',
                  style: TextStyle(color: Color(0xFF75A488), fontSize: 16),
                ),
              ),

              const SizedBox(height: 30),

              TextFormField(
                controller: captionController,
                maxLength: 150,
                decoration: InputDecoration(
                  hintText: 'Add caption...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B5D69),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (_image != null && captionController.text.isNotEmpty) {
                    // 🚀 FIXED: no Post model? send Map instead
                    final newPost = {
                      "username": "User Name",
                      "profilePic": "assets/default_user.png",
                      "imagePath": _image!.path,
                      "rating": 5,
                      "caption": captionController.text,
                    };

                    Navigator.pop(context, newPost); // Pass post data
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please add an image and a caption.'),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Post",
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