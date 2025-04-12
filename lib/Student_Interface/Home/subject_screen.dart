// import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class SubjectScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> subjects = [
//     {'title': 'Math', 'icon': Icons.calculate},
//     {'title': 'Science', 'icon': Icons.science},
//     {'title': 'RE', 'icon': Icons.self_improvement},
//     {'title': 'English', 'icon': Icons.language},
//     {'title': 'ICT', 'icon': Icons.computer},
//     {'title': 'Arabic', 'icon': Icons.translate},
//     {'title': 'PE', 'icon': Icons.sports_soccer},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.blue.shade800,
//         title: const Text('Simple Steps to College Success'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           itemCount: subjects.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             childAspectRatio: 1.2,
//           ),
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => SubjectDetailsScreen(
//                       subject: subjects[index]['title'],
//                       subjectId: '',
//                       subjectTitle: '',
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade400,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 6,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(subjects[index]['icon'],
//                         size: 50, color: Colors.white),
//                     const SizedBox(height: 12),
//                     Text(
//                       subjects[index]['title'],
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class SubjectDetailsScreen extends StatefulWidget {
//   final String subjectId;
//   final String subjectTitle;

//   const SubjectDetailsScreen(
//       {required this.subjectId, required this.subjectTitle, required subject});

//   @override
//   State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
// }

// class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
//   late Future<Map<String, dynamic>> subjectContent;

//   @override
//   void initState() {
//     super.initState();
//     subjectContent = fetchSubjectContent();
//   }

//   Future<Map<String, dynamic>> fetchSubjectContent() async {
//     final response = await http
//         .get(Uri.parse('https://yourapi.com/subjects/${widget.subjectId}'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load subject content');
//     }
//   }

//   Future<void> downloadPDF(String url, String title) async {
//     final status = await Permission.storage.request();
//     if (!status.isGranted) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Storage permission denied')));
//       return;
//     }

//     final dir = await getExternalStorageDirectory();
//     final savePath = '${dir!.path}/$title.pdf';

//     try {
//       await Dio().download(url, savePath);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Downloaded $title')));
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Download failed')));
//     }
//   }

//   void openYouTube(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Could not open YouTube')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.subjectTitle)),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: subjectContent,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting)
//             return Center(child: CircularProgressIndicator());
//           if (snapshot.hasError)
//             return Center(child: Text('Error: ${snapshot.error}'));

//           final pdfs = snapshot.data!['pdfs'] as List<dynamic>;
//           final youtubeLinks = snapshot.data!['youtube_links'] as List<dynamic>;

//           return SingleChildScrollView(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('📄 PDF Resources',
//                     style: Theme.of(context).textTheme.titleMedium),
//                 SizedBox(height: 8),
//                 ...pdfs.map((pdf) => Card(
//                       child: ListTile(
//                         leading: Icon(Icons.picture_as_pdf, color: Colors.red),
//                         title: Text(pdf['title']),
//                         trailing: ElevatedButton.icon(
//                           onPressed: () =>
//                               downloadPDF(pdf['url'], pdf['title']),
//                           icon: Icon(Icons.download),
//                           label: Text('Download'),
//                         ),
//                       ),
//                     )),
//                 SizedBox(height: 24),
//                 Text('🎥 YouTube Lessons',
//                     style: Theme.of(context).textTheme.titleMedium),
//                 SizedBox(height: 8),
//                 ...youtubeLinks.map((yt) => Card(
//                       child: ListTile(
//                         leading: Icon(Icons.ondemand_video, color: Colors.red),
//                         title: Text(yt['title']),
//                         trailing: ElevatedButton.icon(
//                           onPressed: () => openYouTube(yt['url']),
//                           icon: Icon(Icons.open_in_new),
//                           label: Text('Watch'),
//                         ),
//                       ),
//                     )),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SubjectScreen extends StatelessWidget {
  final List<Map<String, dynamic>> subjects = [
    {'title': 'Math', 'icon': Icons.calculate},
    {'title': 'Science', 'icon': Icons.science},
    {'title': 'RE', 'icon': Icons.self_improvement},
    {'title': 'English', 'icon': Icons.language},
    {'title': 'ICT', 'icon': Icons.computer},
    {'title': 'Arabic', 'icon': Icons.translate},
    {'title': 'PE', 'icon': Icons.sports_soccer},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text('Simple Steps to College Success'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: subjects.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SubjectDetailsScreen(
                      subject: subjects[index]['title'],
                      subjectId: '',
                      subjectTitle: subjects[index]['title'],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(subjects[index]['icon'],
                        size: 50, color: Colors.white),
                    const SizedBox(height: 12),
                    Text(
                      subjects[index]['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SubjectDetailsScreen extends StatefulWidget {
  final String subjectId;
  final String subjectTitle;
  final String subject;

  const SubjectDetailsScreen({
    required this.subjectId,
    required this.subjectTitle,
    required this.subject,
  });

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  late Future<Map<String, dynamic>> subjectContent;

  @override
  void initState() {
    super.initState();
    subjectContent = fetchSubjectContent();
  }

  Future<Map<String, dynamic>> fetchSubjectContent() async {
    final response = await http.get(Uri.parse("https://run.mocky.io/v3/6444976a-4060-4a39-b0ef-2e640d2ff88b"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load subject content');
    }
  }

  Future<void> downloadPDF(String url, String title) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Storage permission denied')));
      return;
    }

    final dir = await getExternalStorageDirectory();
    final savePath = '${dir!.path}/$title.pdf';

    try {
      await Dio().download(url, savePath);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Downloaded $title')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Download failed')));
    }
  }

  void openYouTube(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open YouTube')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.subjectTitle)),
      body: FutureBuilder<Map<String, dynamic>>(
        future: subjectContent,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));

          final pdfs = snapshot.data!['pdfs'] as List<dynamic>;
          final youtubeLinks = snapshot.data!['youtube_links'] as List<dynamic>;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('📄 PDF Resources',
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 8),
                ...pdfs.map((pdf) => Card(
                      child: ListTile(
                        leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                        title: Text(pdf['title']),
                        trailing: ElevatedButton.icon(
                          onPressed: () =>
                              downloadPDF(pdf['url'], pdf['title']),
                          icon: Icon(Icons.download),
                          label: Text('Download'),
                        ),
                      ),
                    )),
                SizedBox(height: 24),
                Text('🎥 YouTube Lessons',
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 8),
                ...youtubeLinks.map((yt) => Card(
                      child: ListTile(
                        leading:
                            Icon(Icons.ondemand_video, color: Colors.red),
                        title: Text(yt['title']),
                        trailing: ElevatedButton.icon(
                          onPressed: () => openYouTube(yt['url']),
                          icon: Icon(Icons.open_in_new),
                          label: Text('Watch'),
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
