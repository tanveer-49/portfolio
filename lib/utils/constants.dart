class AppConstants {
  // Personal Info
  static const String name = 'Muhammad Tanveer';
  static const String title = 'Flutter Developer | Full Stack Developer';
  static const String subtitle = 'Internship in Full Stack Development';
  static const String location = '22-G, Wah Cantt Taxila, Rawalpindi, Pakistan';
  static const String email = 'tanveerqureshi2k23@gmail.com';
  static const String phone = '+92 304 3283449';

  // Social Links
  static const String linkedin = 'https://linkedin.com/in/tanveer-qureshi-2k20';
  static const String github = 'https://github.com/tanveer-qureshi-49';

  // Summary
  static const String summary = '''
Motivated 6th Semester BS Computer Science student with skills in Flutter, Firebase, 
MySQL, Java, C++, UI Designing, and basic Full Stack Development. Experienced in 
developing academic and personal mobile application projects with strong problem-solving, 
teamwork, and quick learning abilities. Passionate about learning new technologies and 
building real-world applications.
''';

  // Education
  static final List<Education> educationList = [
    Education(
      institution: 'Allama Iqbal Open University',
      degree: 'BACHELOR, Computer Science',
      duration: '2023 — 2027',
      details: 'Department of Computer Science (Continue) With 3.2 CGPA AIOU Islamabad',
    ),
    Education(
      institution: 'Government Degree College Sehwan',
      degree: 'INTERMEDIATE, Pre-Engineering',
      duration: '2021 — 2023',
      details: 'Intermediate in Engineering With B Grade BISE Hyderabad',
    ),
  ];

  // Skills
  static final List<Skill> skills = [
    // Mobile Development
    Skill(
      category: 'Mobile Application Development',
      items: [
        'Cross-platform mobile applications using Flutter (Dart)',
        'Responsive, user-friendly interfaces following Material Design',
        'Scalable apps using reusable widgets',
      ],
    ),
    // Backend & Integration
    Skill(
      category: 'Backend & Integration',
      items: [
        'Firebase Authentication',
        'Cloud Firestore Database',
        'REST API Integration (JSON-based APIs)',
      ],
    ),
    // Programming Languages
    Skill(
      category: 'Programming Languages',
      items: ['Dart', 'Java', 'Python', 'C++'],
    ),
    // Tools & Technologies
    Skill(
      category: 'Tools & Technologies',
      items: ['Android Studio', 'VS Code', 'Git & GitHub', 'Firebase Console'],
    ),
    // Databases
    Skill(
      category: 'Databases',
      items: ['MySQL', 'MongoDB', 'Firebase', 'Firestore'],
    ),
    // Other Skills
    Skill(
      category: 'Other Skills',
      items: [
        'Debugging & Error Handling',
        'Performance Optimization Basics',
        'MS Office',
      ],
    ),
  ];

  // Projects
  static final List<Project> projects = [
    Project(
      title: 'UniMoves',
      subtitle: 'University Transport Management System',
      description: '''
Developed a cross-platform University Transport Management application using Flutter (Dart) and Firebase.
• Designed responsive UI for bus management, route tracking, user management, and notification features
• Implemented Firebase Authentication and Firestore database for secure user and admin operations
• Applied modular architecture with reusable widgets and organized project structure for scalability and maintainability
''',
      technologies: ['Flutter', 'Dart', 'Firebase', 'Firestore', 'Material Design'],
      imageUrl: 'assets/images/unimoves.png',
      githubUrl: 'https://github.com/tanveer-qureshi-49/unimoves',
      liveUrl: 'https://unimoves-demo.com',
    ),
    Project(
      title: 'Hospital Management Database System',
      subtitle: 'MySQL Database Project',
      description: '''
Designed and implemented a relational database system for hospital operations.
• Created normalized tables including Patient, Doctor, Appointment, Billing, and Staff
• Applied primary/foreign key constraints to ensure data integrity
• Managed structured datasets efficiently for real-world simulation
''',
      technologies: ['MySQL', 'Database Design', 'SQL', 'Data Modeling'],
      imageUrl: 'assets/images/hospital_db.png',
      githubUrl: 'https://github.com/tanveer-qureshi-49/hospital-db',
      liveUrl: '',
    ),
  ];

  // Certifications
  static final List<String> certifications = [
    'Flutter & Dart',
    'Full Stack Development',
    'Mobile Notification & App Database',
    'Python Programming',
  ];
}

// ========== MODEL CLASSES ==========

class Education {
  final String institution;
  final String degree;
  final String duration;
  final String details;

  Education({
    required this.institution,
    required this.degree,
    required this.duration,
    required this.details,
  });
}

class Skill {
  final String category;
  final List<String> items;

  Skill({
    required this.category,
    required this.items,
  });
}

class Project {
  final String title;
  final String subtitle;
  final String description;
  final List<String> technologies;
  final String imageUrl;
  final String githubUrl;
  final String liveUrl;

  Project({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.technologies,
    required this.imageUrl,
    required this.githubUrl,
    required this.liveUrl,
  });
}