import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';  // Import the provider file
import 'package:image_picker/image_picker.dart';
void main() {
  runApp(P2Page());
}
class P2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the list of projects from the provider
    final projects = Provider.of<ProjectProvider>(context).projects;

    return Scaffold(
      appBar: AppBar(
        title: const Text("P2 Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display a "Welcome" message
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Display all projects created
            Expanded(
              child: ListView.builder(
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
            ),
          ],
        ),
      ),
    );
  }
}
