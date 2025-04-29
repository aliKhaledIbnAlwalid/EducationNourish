import 'package:edunourish/features/student/screens/list/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edunourish/features/student/providers/student_provider.dart';
import 'package:edunourish/core/models/subject_info.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<StudentProvider>();

    // 1) loading
    if (prov.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final subjects = prov.subjects;
    // 2) empty state
    if (subjects.isEmpty) {
      return const Center(child: Text('No subjects available.'));
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffcdc9cf), Color(0xffe8e6e9)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildAppBar(context),
                  const SizedBox(height: 20),
                  _buildSearchField(),
                  const SizedBox(height: 20),
                  // 3) grid of subjects
                  Expanded(
                    child: GridView.builder(
                      itemCount: subjects.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (ctx, i) => _buildSubjectCard(
                        context,
                        subjects[i],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // back
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        const Text(
          "Subjects",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        // profile
        GestureDetector(
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, color: Colors.black54),
          ),
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfilePageStudent(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search subjects…",
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, SubjectInfo s) {
    IconData icon;
    switch (s.category.toLowerCase()) {
      case 'math':
        icon = Icons.calculate;
        break;
      case 'science':
        icon = Icons.science;
        break;
      case 'english':
        icon = Icons.language;
        break;
      case 'arabic':
        icon = Icons.translate;
        break;
      case 'ict':
        icon = Icons.computer;
        break;
      case 'pe':
        icon = Icons.sports_soccer;
        break;
      case 're':
        icon = Icons.self_improvement;
        break;
      default:
        icon = Icons.book;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SubjectDetailScreen(subject: s),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // icon at top
            Expanded(
              child: Center(
                child: Icon(icon, size: 48, color: Colors.blueGrey),
              ),
            ),
            const SizedBox(height: 8),
            // subject name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                s.name,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // optional description
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                s.description,
                style:
                    const TextStyle(fontSize: 14, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}


class SubjectDetailScreen extends StatelessWidget {
  final SubjectInfo subject;

  const SubjectDetailScreen({Key? key, required this.subject})
      : super(key: key);

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subject.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow('Code', subject.code),
            _infoRow('Category', subject.category),
            _infoRow('Grade Level', subject.gradeLevel),
            _infoRow('Semester', subject.semester),
            const SizedBox(height: 12),
            const Text('Description:',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(subject.description),
          ],
        ),
      ),
    );
  }
}
