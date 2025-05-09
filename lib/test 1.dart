import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:mihna_app/core/provider/project_provider.dart';
import 'package:mihna_app/core/domain/models/project_model.dart';
import 'package:mihna_app/core/widgets/title_input.dart';
import 'package:mihna_app/core/widgets/description_input.dart';
import 'package:mihna_app/core/widgets/post_button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostProjectScreen extends StatefulWidget {
  const PostProjectScreen({super.key});

  @override
  _PostProjectScreenState createState() => _PostProjectScreenState();
}

class _PostProjectScreenState extends State<PostProjectScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _imagePath = '';
  XFile? _pickedFile;
  bool _isPosting = false;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _pickedFile = pickedFile;
          _imagePath = pickedFile.path;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<String> uploadImage(XFile file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('project_images/$fileName');

      UploadTask uploadTask = storageRef.putFile(File(file.path));
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Image upload failed: ${e.toString()}');
    }
  }

  Future<void> _postProject() async {
    if (_isPosting) return;

    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in both title and description'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isPosting = true;
    });

    try {
      String imageUrl = '';
      if (_pickedFile != null) {
        imageUrl = await uploadImage(_pickedFile!);
      }

      final newProject = Project(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        imagePath: imageUrl,
      );

      // Add to Firestore
      await FirebaseFirestore.instance.collection('projects').doc(newProject.id).set({
        'id': newProject.id,
        'title': newProject.title,
        'description': newProject.description,
        'imagePath': newProject.imagePath,
        'createdAt': Timestamp.now(),
      });

      // Add to local state
      Provider.of<ProjectProvider>(context, listen: false).addProject(newProject);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Project posted successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to post project: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPosting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post Project"),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const SizedBox(height: 20),
            TitleInput(controller: _titleController),
            const SizedBox(height: 16),
            DescriptionInput(
              controller: _descriptionController,
              onImagePressed: _pickImage,
            ),
            const SizedBox(height: 16),
            if (_imagePath.isNotEmpty)
        Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: kIsWeb
    ? Image.network(
    _imagePath,
    width: 100,
    height: 100,
    errorBuilder: (, _, _) => Container(
    width: 100,
    height: 100,
    color: Colors.grey[200],
    child: const Center(
    child: Icon(Icons.broken_image, size: 50),
    ),
    ),
    )
        : Image.file(
    File(_imagePath),
    width: 100,
    height: 100,
    errorBuilder: (, _, _) => Container(
    width: 100,
    height: 100,
    color: Colors.grey[200],
    child: const Center(
    child: Icon(Icons.broken_image, size: 50),
    ),
    ),
    ),
    ),
    PostButton(
    onPressed: () {
    if (_titleController.text.isNotEmpty &&
    _descriptionController.text.isNotEmpty) {
    final newProject = Project(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    title: _titleController.text,
    description: _descriptionController.text,
    imagePath: _imagePath,
    );
    Provider.of<ProjectProvider>(context, listen: false)
        .addProject(newProject);
    Navigator.pop(context);
    }
    },
    ),
    ],
    ),
    ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}