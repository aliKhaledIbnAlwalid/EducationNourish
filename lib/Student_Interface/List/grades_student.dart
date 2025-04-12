import 'package:flutter/material.dart';

class GradeScreen extends StatelessWidget {
  const GradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: GradeScreenBody());
  }
}

class GradeScreenBody extends StatelessWidget {
  const GradeScreenBody({super.key});

  // Helper method to get letter grade based on numerical grade
  String _getLetterGrade(double grade) {
    if (grade >= 90) return 'A';
    if (grade >= 80) return 'B';
    if (grade >= 70) return 'C';
    if (grade >= 60) return 'D';
    return 'F';
  }

  @override
  Widget build(BuildContext context) {
    final List<Subject> subjects = [
      Subject(
          name: "Arabic",
          assignmentGrade: 88,
          quizGrade: 85,
          finalGrade: 82,
          color: Colors.red.shade400),
      Subject(
          name: "Math",
          assignmentGrade: 85,
          quizGrade: 78,
          finalGrade: 90,
          color: Colors.blue.shade400),
      Subject(
          name: "PE",
          assignmentGrade: 72,
          quizGrade: 80,
          finalGrade: 75,
          color: Colors.green.shade400),
      Subject(
          name: "Science",
          assignmentGrade: 78,
          quizGrade: 75,
          finalGrade: 80,
          color: Colors.purple.shade400),
      Subject(
          name: "ICT",
          assignmentGrade: 95,
          quizGrade: 92,
          finalGrade: 88,
          color: Colors.orange.shade400),
      Subject(
          name: "English",
          assignmentGrade: 83,
          quizGrade: 66,
          finalGrade: 89,
          color: Colors.teal.shade400),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Grade Screen")),
      body: Column(
        children: [
          const Text("Grades",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                final avgGrade = (subject.assignmentGrade +
                        subject.quizGrade +
                        subject.finalGrade) /
                    3;
                final letterGrade = _getLetterGrade(avgGrade);

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Subject header with color bar
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: subject.color.withOpacity(0.2),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                minWidth: 80, // Minimum width
                                maxWidth: 180, // Maximum width
                              ),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: subject.color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                subject.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color:
                                    avgGrade >= 70 ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                letterGrade,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Grade details
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GradeColumn(
                              label: 'Assignment',
                              grade: subject.assignmentGrade,
                              showIcon: true,
                              icon: Icons.assignment,
                            ),
                            GradeColumn(
                              label: 'Quiz',
                              grade: subject.quizGrade,
                              showIcon: true,
                              icon: Icons.quiz,
                            ),
                            GradeColumn(
                              label: 'Final',
                              grade: subject.finalGrade,
                              showIcon: true,
                              icon: Icons.school,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Subject {
  final String name;
  final double assignmentGrade;
  final double quizGrade;
  final double finalGrade;
  final Color color;

  Subject({
    required this.name,
    required this.assignmentGrade,
    required this.quizGrade,
    required this.finalGrade,
    this.color = Colors.blue,
  });
}

class GradeColumn extends StatelessWidget {
  final String label;
  final double grade;
  final bool showIcon;
  final IconData? icon;

  const GradeColumn({
    super.key,
    required this.label,
    required this.grade,
    this.showIcon = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Determine color based on grade
    Color gradeColor;
    if (grade >= 80) {
      gradeColor = Colors.green;
    } else if (grade >= 70) {
      gradeColor = Colors.orange;
    } else {
      gradeColor = Colors.red;
    }

    return Column(
      children: [
        if (showIcon && icon != null)
          Icon(icon, size: 20, color: Colors.grey.shade700),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$grade%',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: gradeColor,
          ),
        ),
      ],
    );
  }
}
