// project_provider.dart
import 'project model.dart';
import 'package:flutter/material.dart';

class ProjectProvider with ChangeNotifier {
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  // Add a new project to the list
  void addProject(Project project) {
    _projects.add(project);
    notifyListeners(); // Notify listeners about the update
  }
}
