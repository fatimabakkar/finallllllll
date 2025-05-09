import 'package:flutter/material.dart';
import 'dart:io';


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

class ProjectList extends StatefulWidget {
  const ProjectList({super.key});

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  List<Project> projects = []; // List to hold projects

  // Navigate to AddProject page and get the project data back
  void _navigateToAddProject(BuildContext context) async {
    final project = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  PostPage()),
    );

    if (project != null) {
      setState(() {
        projects.add(project); // Add the new project to the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Project Cards")),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]); // Display each project in a card
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddProject(context), // Navigate to AddProject page
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProjectList(),
  ));
}
