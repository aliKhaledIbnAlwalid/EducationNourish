import 'package:edunourish/Student_Interface/BtmNavBar/profile_page_student.dart';
import 'package:flutter/material.dart';

class Restaurant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffcdc9cf),
                  Color(0xffe8e6e9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child:
                            const Icon(Icons.arrow_back, color: Colors.black),
                        onTap: () {
                          Navigator.pop(
                            context,
                          );
                        },
                      ),
                      const Text("Food PLace",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        child: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: const Icon(Icons.person)),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePageStudent(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Dishes, restaurants, groceries & more",
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.mic),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("It's Canteen",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const Text("Get festive-ready with Swiggy!",
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        _buildCategoryCard('Food Delivery', 'UPTO 60% OFF',
                            "assets/student/Home_Student/Toast.png"),
                        _buildCategoryCard(
                          'Instamart',
                          'FLAT ₹100 OFF',
                          "assets/student/Home_Student/Toast.png",
                        ),
                        _buildCategoryCard('Dineout', 'UPTO 50% OFF',
                            "assets/student/Home_Student/Toast.png"),
                        _buildCategoryCard('Genie', 'Pick-up & Drop',
                            "assets/student/Home_Student/Toast.png"),
                        _buildCategoryCard('Genie', 'Pick-up & Drop',
                            "assets/student/Home_Student/Toast.png"),
                        _buildCategoryCard('Genie', 'Pick-up & Drop',
                            "assets/student/Home_Student/Toast.png"),
                        _buildCategoryCard('Genie', 'Pick-up & Drop',
                            "assets/student/Home_Student/Toast.png"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text("WHAT'S HOT",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, String offer, String imagePath) {
    return Card(
      color: const Color(0xff98afb0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 60),
          const SizedBox(height: 10),
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(offer,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
