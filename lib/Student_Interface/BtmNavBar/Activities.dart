import 'package:flutter/material.dart';

class Activities extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'General', 'image': "assets/student/Home_Student/General.png"},
    {
      'title': 'Competitions',
      'image': "assets/student/Home_Student/Competitons.png"
    },
    {'title': 'Trips', 'image': "assets/student/Home_Student/Trips.png"},
    {'title': 'Parties', 'image': "assets/student/Home_Student/Parties.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcdc9cf),
      appBar: AppBar(
        title: const Text("Activities"),
        centerTitle: true,
        backgroundColor: const Color(0xffcdc9cf),
        leading: const Icon(Icons.notifications_none_outlined, size: 30),
        actions: const [
          Image(
            image: AssetImage('assets/Intro_Screen_login/EduIcon.png'),
            height: 50,
            width: 50,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            title: categories[index]['title']!,
            image: categories[index]['image']!,
          );
        },
      ),
    );
  }
}

// ---------- Category Card ----------
class CategoryCard extends StatelessWidget {
  final String title;
  final String image;

  const CategoryCard({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to LoadingScreen with category title
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingScreen(title: title),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xff98afb0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

// ---------- Loading Screen ----------
class LoadingScreen extends StatefulWidget {
  final String title;

  const LoadingScreen({required this.title});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    // Wait 2 seconds then navigate
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewsScreen(category: widget.title),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
        leading: const BackButton(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Loading...", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              minHeight: 4,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightBlue),
              backgroundColor: Colors.green.shade200,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- News Screen ----------
class NewsScreen extends StatelessWidget {
  final String category;

  const NewsScreen({required this.category});

  // Dummy data per category (for example purposes)
  List<Map<String, String>> getNewsData(String category) {
    switch (category) {
      case "General":
        return [
          {
            "title":
                "Facebook’s Marketplace in EU, UK antitrust crosshairs Facebook’s Marketplace in EU, UK antitrust crosshairs Facebook’s Marketplace in EU, UK antitrust crosshairs",
            "source": "Reuters",
            "image": "assets/student/Home_Student/Parties.png"
          },
          {
            "title":
                "Stocks making the biggest moves: DocuSign, MongoDB Stocks making the biggest moves: DocuSign, MongoDB Stocks making the biggest moves: DocuSign, MongoDB Stocks making the biggest moves: DocuSign, MongoDB",
            "source": "CNBC",
            "image": "assets/student/Home_Student/Parties.png"
          },
        ];
      case "Trips":
        return [
          {
            "title": "Trip to the Pyramids announced for students",
            "source": "EduTrip",
            "image": "assets/student/Home_Student/Parties.png"
          },
        ];
      case "Parties":
        return [
          {
            "title": "Annual College Party 2025 Highlights",
            "source": "CampusLife",
            "image": "assets/student/Home_Student/Parties.png"
          },
        ];
      case "Competitions":
        return [
          {
            "title": "National Coding Championship Open for Entries",
            "source": "TechArena",
            "image": "assets/student/Home_Student/Parties.png"
          },
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final articles = getNewsData(category);

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.green,
        leading: const BackButton(),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(article["image"]!, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    article["source"]!,
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    article["title"]!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
