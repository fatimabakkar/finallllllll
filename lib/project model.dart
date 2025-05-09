// project.dart
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
