import 'package:flutter/material.dart';

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

class ProjectProvider with ChangeNotifier {
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners(); // Notify listeners about the change
  }
}
