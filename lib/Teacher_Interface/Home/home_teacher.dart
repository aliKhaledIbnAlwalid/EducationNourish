// import 'package:edunourish/Student_Interface/BtmNavBar/Exams.dart';
// import 'package:edunourish/Student_Interface/Home/Attendance.dart';
// import 'package:edunourish/Student_Interface/Home/TaskList.dart';
// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../../Student_Interface/Home/Restaurant.dart';
// import 'notifiactions_screen_teacher.dart';

// class HomeTeacher extends StatefulWidget {
//   const HomeTeacher({super.key});
//   @override
//   State<HomeTeacher> createState() => _HomeTeacherState();
// }

// class _HomeTeacherState extends State<HomeTeacher> {
//   final PageController _pageController = PageController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       extendBody: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.notifications_none_outlined, size: 30),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => NeoNotificationsTeacherScreen(),
//               ),
//             );
//           },
//         ),
//         actions: const [
//           Image(
//             image: AssetImage('assets/Intro_Screen_login/EduIcon.png'),
//             height: 50,
//             width: 50,
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xffcdc9cf),
//                   Color(0xffe8e6e9),
//                 ],
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               // Feature Cards
//               Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     GestureDetector(
//                       child: _buildFeatureCard(
//                           "assets/student/Home_Student/exam.png", "Exams"),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const Exams(),
//                           ),
//                         );
//                       },
//                     ),
//                     GestureDetector(
//                       child: _buildFeatureCard(
//                           "assets/student/Home_Student/Calendar.png",
//                           "Attendance"),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const Attendance(),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     GestureDetector(
//                       child: _buildFeatureCard(
//                           "assets/student/Home_Student/Toast.png",
//                           "Restaurent"),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Restaurant(),
//                           ),
//                         );
//                       },
//                     ),
//                     GestureDetector(
//                       child: _buildFeatureCard(
//                           "assets/student/Home_Student/TaskList.png",
//                           "Task List"),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const Tasklist(),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildFeatureCard(String imagePath, String title) {
//   return Container(
//     width: 170,
//     height: 170,
//     decoration: BoxDecoration(
//       color: const Color(0xff98afb0),
//       borderRadius: BorderRadius.circular(30),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(imagePath, height: 130),
//         Text(title,
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//       ],
//     ),
//   );
// }
import 'package:flutter/material.dart';

class HomeTeacher extends StatelessWidget {
  const HomeTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Teacher Dashboard',
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cardTextStyle = const TextStyle(fontSize: 14, color: Colors.black87);
    final cardNumberStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

    Widget buildStatCard(String label, String count, IconData icon) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.teal, size: 30),
            const SizedBox(height: 8),
            Text("$count Total", style: cardNumberStyle),
            Text(label, textAlign: TextAlign.center, style: cardTextStyle),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header
              const Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150', // replace with profile image
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello", style: TextStyle(fontSize: 16, color: Colors.black54)),
                      Text(
                        "Mr Ahmed Mostafa 👋",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.notifications_none_rounded, size: 28),
                ],
              ),
              const SizedBox(height: 20),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Announcement
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF00B8B0).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.admin_panel_settings, color: Colors.teal),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "A new school policy on student attendance has been implemented. Please review it in the portal.",
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Explore Academics
              const Text(
                "Explore Academics",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
                children: [
                  buildStatCard("Class you have", "5", Icons.class_),
                  buildStatCard("Students you have", "50", Icons.group),
                  buildStatCard("Took the exam", "18", Icons.edit_note),
                  buildStatCard("Homework pushed", "30", Icons.book),
                  buildStatCard("Create Quiz\n(MCQ or written)", "", Icons.quiz),
                  buildStatCard("Create Meeting\n(With parents or students)", "", Icons.video_call),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
