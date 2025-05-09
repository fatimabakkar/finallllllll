import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mihna_app/core/provider/project_provider.dart';
import 'package:mihna_app/core/presentation/screens/project_detail_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'test 1.dart';

class FreelancerPostsScreen extends StatelessWidget {
  const FreelancerPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = context.watch<ProjectProvider>();
    final projects = projectProvider.availableProjects;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        backgroundColor: Colors.white,
      ),
      body: projects.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.work_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No projects available',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectDetailScreen(project: project),
                      ),
                    );
                  },

                  child: Card(
                    elevation: 5,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                            children: [
                            // Project image (80x80)
                            if (project.imagePath.isNotEmpty)
                        ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                    child: kIsWeb
                        ? Image.network(
                        project.imagePath,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (, _, _) =>
                        const Icon(Icons.broken_image, size: 80),
                  )
                      : Image.file(
                  File(project.imagePath),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (, _, _) =>
              const Icon(Icons.broken_image, size: 80),
          ),
          )
          else
          const SizedBox(width: 80),
          const SizedBox(width: 15),

          // Project details
          Expanded(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          project.title,
          style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          ),
          ),
          const SizedBox(height: 5),
          Text(
          project.description,
          style: const TextStyle(color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Row(
          children: [
          const Icon(Icons.access_time, size: 14),
          const SizedBox(width: 4),
          Text(
          'Posted on ${_formatDate(project.createdAt)}',
          style: const TextStyle(fontSize: 12),
          ),
          ],
          ),
          ],
          ),
          ),
          ],
          ),
          ),
          ),
          ),
          );
          },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}