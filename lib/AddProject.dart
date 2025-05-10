import 'package:flutter/material.dart';
import 'dart:io'; // Import to handle images from file system
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'package:provider/provider.dart';
import 'provider.dart';  // Import ProjectProvider

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController skillController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  File? _image;

  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery); // Open gallery

    if (image != null) {
      setState(() {
        _image = File(image.path); // Update the image state
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Project'),
        backgroundColor: const Color(0xFFF2F2F2), // Set the background color to #f2f2f2
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _image == null
                        ? const Center(
                      child: Icon(
                          Icons.camera_alt, color: Colors.white70, size: 40),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                          _image!, fit: BoxFit.cover, width: double.infinity),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Project Name
              _buildTextField(skillController, 'Project Name'),

              // Location
              _buildTextField(locationController, 'Location'),

              // About
              _buildTextField(
                  aboutController, 'About this Project', maxLines: 3),

              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFF4B5D69),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    final newProject = Project(
                      skillController.text,
                      _image?.path ?? '',
                      aboutController.text,
                    );
                    Provider.of<ProjectProvider>(context, listen: false)
                        .addProject(newProject);
                    Navigator.pop(context);
                  },
                  child: const Text(
                      'Post Project', style: TextStyle(color:Colors.white,fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14),
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
