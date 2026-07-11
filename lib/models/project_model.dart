class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String liveUrl;
  final String githubUrl;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.liveUrl,
    required this.githubUrl,
  });
}

class Skill {
  final String name;
  final String icon;
  final double proficiency;

  Skill({
    required this.name,
    required this.icon,
    required this.proficiency,
  });
}