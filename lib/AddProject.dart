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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: Container(
                    width: 274,
                    height: 200,
                    color: Colors.grey[500],
                    child: _image == null
                        ? const Center(
                      child: Icon(Icons.camera_alt, color: Colors.white, size: 40),
                    )
                        : Image.file(_image!, fit: BoxFit.cover),
                  ),
                ),
              ),
              TextFormField(controller: skillController, decoration: InputDecoration(hintText: 'Project Name')),
              TextFormField(controller: locationController, decoration: InputDecoration(hintText: 'Location')),
              TextFormField(controller: aboutController, decoration: InputDecoration(hintText: 'About this Project')),
              // Button to create and pass the project data
              ElevatedButton(
                onPressed: () {
                  final newProject = Project(
                    skillController.text,
                    _image?.path ?? '', // If no image, pass an empty string
                    aboutController.text,
                  );

                  // Add the new project to the provider and go back to the previous page
                  Provider.of<ProjectProvider>(context, listen: false)
                      .addProject(newProject);
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: Text('Post Project'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
