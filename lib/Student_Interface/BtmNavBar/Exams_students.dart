import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamsStudents extends StatelessWidget {
  const ExamsStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff98afb0),
      appBar: AppBar(
        title: const Text(
          'Exam Schedule',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        actions: const [
          Image(
            image: AssetImage('assets/Intro_Screen_login/EduIcon.png'),
            height: 50,
            width: 50,
          ),
        ],
      ),
      body: const ExamScreenBody(),
    );
  }
}

class Exam {
  final String type;
  final String subject;
  final DateTime dateTime;

  Exam({required this.type, required this.subject, required this.dateTime});
}

class ExamScreenBody extends StatefulWidget {
  const ExamScreenBody({super.key});

  @override
  State<ExamScreenBody> createState() => _ExamScreenBodyState();
}

class _ExamScreenBodyState extends State<ExamScreenBody> {
  final List<Exam> exams = [
    Exam(
        type: 'Midterm',
        subject: 'Math',
        dateTime: DateTime(2025, 5, 15, 10, 0)),
    Exam(
        type: 'Final',
        subject: 'Arabic',
        dateTime: DateTime(2025, 6, 20, 14, 0)),
    Exam(
        type: 'Quiz',
        subject: 'English',
        dateTime: DateTime(2025, 5, 10, 9, 30)),
    Exam(
        type: 'Midterm',
        subject: 'Science',
        dateTime: DateTime(2025, 5, 25, 11, 0)),
    Exam(
        type: 'Final', subject: 'Math', dateTime: DateTime(2025, 6, 15, 13, 0)),
  ];

  String? selectedType;
  String? selectedSubject;

  Color getExamTypeColor(String type) {
    switch (type) {
      case 'Midterm':
        return Colors.amber.shade700;
      case 'Final':
        return Colors.red.shade700;
      case 'Quiz':
        return Colors.green.shade700;
      default:
        return Colors.blue.shade700;
    }
  }

  IconData getSubjectIcon(String subject) {
    switch (subject) {
      case 'Math':
        return Icons.calculate;
      case 'Arabic':
        return Icons.language;
      case 'English':
        return Icons.book;
      case 'Science':
        return Icons.science;
      default:
        return Icons.subject;
    }
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('MMM d, yyyy').format(dateTime);
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  List<Exam> get filteredExams {
    return exams
        .where((exam) =>
            (selectedType == null || exam.type == selectedType) &&
            (selectedSubject == null || exam.subject == selectedSubject))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterSection(),
        const SizedBox(height: 8),
        _buildExamList(),
      ],
    );
  }

  // Widget _buildFilterSection() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: _buildDropdown(
  //             labelText: 'Exam Type',
  //             hintText: 'All',
  //             value: selectedType,
  //             items: exams.map((e) => e.type).toSet().toList(),
  //             onChanged: (value) => setState(() => selectedType = value),
  //           ),
  //         ),
  //         const SizedBox(width: 16),
  //         Expanded(
  //           child: _buildDropdown(
  //             labelText: 'Exam Subject',
  //             hintText: 'All',
  //             value: selectedSubject,
  //             items: exams.map((e) => e.subject).toSet().toList(),
  //             onChanged: (value) => setState(() => selectedSubject = value),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildFilterSection() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8.0),
            child: _buildDropdown(
              labelText: 'Exam Type',
              hintText: 'All',
              value: selectedType,
              items: exams.map((e) => e.type).toSet().toList(),
              onChanged: (value) => setState(() => selectedType = value),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8.0),
            child: _buildDropdown(
              labelText: 'Exam Subject',
              hintText: 'All',
              value: selectedSubject,
              items: exams.map((e) => e.subject).toSet().toList(),
              onChanged: (value) => setState(() => selectedSubject = value),
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildDropdown({
    required String labelText,
    required String hintText,
    required String? value,
    required List<String> items,
    required void Function(String?)? onChanged,
  }) {
    List<DropdownMenuItem<String>> dropdownItems = [];

    dropdownItems.add(
      DropdownMenuItem<String>(
        value: null,
        child: Text(hintText, style: const TextStyle(color: Colors.black)),
      ),
    );

    for (String item in items) {
      dropdownItems.add(
        DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        ),
      );
    }

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      value: value,
      items: dropdownItems,
      onChanged: onChanged,
      hint: Text(hintText),
      isExpanded: true,
    );
  }

  Widget _buildExamList() {
    if (filteredExams.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy,
                size: 64,
                color: Colors.grey.shade400,
              ),
             const SizedBox(height: 10),
              const Text(
                'No exams found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredExams.length,
        itemBuilder: (context, index) {
          final exam = filteredExams[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            getExamTypeColor(exam.type).withOpacity(0.2),
                        radius: 24,
                        child: Icon(
                          getSubjectIcon(exam.subject),
                          color: getExamTypeColor(exam.type),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    exam.subject,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  constraints: const BoxConstraints(
                                      minWidth: 80, maxWidth: 140),
                                  decoration: BoxDecoration(
                                    color: getExamTypeColor(exam.type),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    exam.type,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 16, color: Colors.grey.shade600),
                                const SizedBox(width: 6),
                                Text(
                                  _formatDate(exam.dateTime),
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Icon(Icons.access_time,
                                    size: 16, color: Colors.grey.shade600),
                                const SizedBox(width: 6),
                                Text(
                                  _formatTime(exam.dateTime),
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}




























//           const Positioned(
//             top: 16,
//             right: 16,
//             child: Icon(Icons.notifications, color: Colors.red),
//           ),
