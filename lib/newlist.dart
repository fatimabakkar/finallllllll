import 'package:flutter/material.dart';
import 'dart:io';
import 'AddProject.dart';
import 'p2.dart';
import 'AddProject.dart';
import 'package:provider/provider.dart';
import 'provider.dart';
final projects =[]; // Fetching projects from the provider

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
          project.image.isNotEmpty
              ? Image.file(File(project.image)) // Display image if path is not empty
              : Container(
            width: double.infinity,
            height: 150,
            color: Colors.grey[300], // Placeholder if no image
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
    );
  }
}

class ProjectList extends StatefulWidget {
  const ProjectList({super.key});

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Project Cards")),
      body: Consumer<ProjectProvider>(
        builder: (context, projectProvider, child) {
        final projects = projectProvider.projects; // Fetching projects from the provider

          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(project: projects[index]); // Display each project in a card
            },
          );
        },
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
                icon: const Icon(Icons.home, size: 34, color: Color(0xFF75A488)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => P2Page()),
                  );
                },
              ),
              // Empty widget to create space for floating action button
              Container(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>PostPage()),
      );        },
        child: const Icon(Icons.add),
      ),
    );
  }


  void _navigateToAddProject(BuildContext context) async {
    final project = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostPage()),
    );

    if (project != null) {
      Provider.of<ProjectProvider>(context, listen: false)
          .addProject(project); // Add project to provider
    }
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => P2Page()),
                  );
                },
              ),
              // Empty widget to create space for floating action button
              Container(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => P2Page()),
          );        },
        child: const Icon(Icons.add),
      ),
    );
  }


//, Correctly call the method
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProjectProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProjectList(), // Start with the ProjectList
    );
  }
}

