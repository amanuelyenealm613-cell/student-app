class Student {
  final String id;
  final String name;
  final String department;
  final String level;
  final String email;
  final List<String> enrolledCourses;

  Student({
    required this.id,
    required this.name,
    required this.department,
    required this.level,
    required this.email,
    this.enrolledCourses = const [],
  });

  // JSON ወደ Student Object ለመቀየር
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      department: json['department'] ?? 'Software Engineering',
      level: json['level'] ?? 'Level 3',
      email: json['email'] ?? '',
      enrolledCourses: json['enrolledCourses'] != null
          ? List<String>.from(json['enrolledCourses'])
          : [],
    );
  }

  // Student Object ወደ JSON ለመቀየር
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'level': level,
      'email': email,
      'enrolledCourses': enrolledCourses,
    };
  }
}