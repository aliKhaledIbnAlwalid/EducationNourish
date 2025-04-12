import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HeroModal> heroes = [];
  List<Color> colors = [
    const Color(0xff98afb0),
    const Color(0xff98afb0),
    const Color(0xff98afb0),
  ];

  @override
  void initState() {
    loadHeroes();
    super.initState();
  }

  //To load and decode the json file from assets
  Future<void> loadHeroes() async {
    String jsonData =
        await rootBundle.loadString('assets/json/heros_info.json');
    List<dynamic> data = json.decode(jsonData)['heroes'];
    List<HeroModal> heroList =
        data.map((hero) => HeroModal.fromJson(hero)).toList();
    setState(() {
      heroes = heroList;
    });

    heroes.map((e) => print(e.heroName)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Teachers",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xffcdc9cf),
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
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffcdc9cf),
                  Color(0xffe8e6e9),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (heroes.isNotEmpty)
                  Center(
                    child: SizedBox(
                      width: deviceSize.width,
                      height: deviceSize.height * 0.8,
                      child: CarouselSlider.builder(
                          options: CarouselOptions(
                            viewportFraction: 0.8,
                            reverse: false,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            disableCenter: true,
                            enlargeFactor: 0.3,
                          ),
                          itemCount: heroes.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            final hero = heroes[itemIndex];
                            return GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => DetailScreen(
                                //       color: colors[itemIndex],
                                //       hero: hero,
                                //     ),
                                //   ),
                                // );
                              },
                              child: HerosCardWidget(
                                key: UniqueKey(),
                                deviceSize: deviceSize,
                                heroLogo: hero.heroLogo,
                                heroInfo: hero.heroInfo,
                                heroName: hero.heroName,
                                color: colors[itemIndex],
                              ),
                            );
                          }),
                    ),
                  ),
              ],
            ),
          ),
        ]));
  }
}

/// second file (detail_screen.dart)

// class DetailScreen extends StatefulWidget {
//   final Color color;
//   final HeroModal hero;
//   const DetailScreen({Key? key, required this.color, required this.hero})
//       : super(key: key);

//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   bool animate = false;

//   bool reverseScroll = false;
//   ScrollController scrollController = ScrollController();
//   @override
//   void initState() {
//     Future.delayed(const Duration(milliseconds: 200), () {
//       setState(() {
//         animate = true;
//       });
//     }).then(
//       (value) {
//         setState(() {
//           reverseScroll = true;
//         });
//       },
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: widget.color,
//         elevation: 0,
//       ),
//       backgroundColor: widget.color,
//       body: Stack(
//         children: [
//           Stack(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: deviceSize.height * 0.4,
//                   ),
//                   Text(
//                     widget.hero.heroName,
//                     style: const TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Text(
//                       widget.hero.heroInfo,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 7,
//                       style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.white),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           customDraggableSheet()
//         ],
//       ),
//     );
//   }

//   Widget customDraggableSheet() {
//     final hight = MediaQuery.sizeOf(context).height;
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: AnimatedContainer(
//         height: reverseScroll ? hight * 0.60 : hight * 0.24,
//         curve: Curves.easeInOutBack,
//         duration: const Duration(milliseconds: 1500),
//         child: Material(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(15),
//             topRight: Radius.circular(15),
//           ),
//           child: NotificationListener<UserScrollNotification>(
//             onNotification: (notification) {
//               final ScrollDirection direction = notification.direction;
//               SchedulerBinding.instance.addPostFrameCallback((_) {
//                 if (mounted) {
//                   setState(() {
//                     if (direction == ScrollDirection.reverse &&
//                         notification.metrics.axis == Axis.vertical) {
//                       reverseScroll = true;
//                     } else if (direction == ScrollDirection.forward &&
//                         notification.metrics.axis == Axis.vertical) {
//                       reverseScroll = false;
//                     }
//                   });
//                 }
//               });

//               return true;
//             },
//             child: SingleChildScrollView(
//               controller: scrollController,
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(left: 14.0, top: 14),
//                     child: Text(
//                       "Latest News",
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                   ),
//                   SizedBox(
//                     height: hight * 0.20,
//                     child: ListView.builder(
//                         physics: const BouncingScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         itemCount: widget.hero.heroLatestNews.length,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             width: 250,
//                             margin: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                   widget.hero.heroLatestNews[index],
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 14.0, top: 8),
//                     child: Text(
//                       "Related Movies",
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                   ),
//                   SizedBox(
//                     height: hight * 0.30,
//                     child: ListView.builder(
//                         physics: const BouncingScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         itemCount: widget.hero.heroLatestNews.length,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             width: 150,
//                             margin: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                   widget.hero.relatedMovies[index],
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//                   Container(
//                     height: hight * 0.03,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

/// third file (hero_Model_Widget.dart)

class HerosCardWidget extends StatefulWidget {
  const HerosCardWidget({
    super.key,
    required this.deviceSize,
    required this.heroLogo,
    required this.heroName,
    required this.heroInfo,
    required this.color,
  });

  final Size deviceSize;

  final String heroLogo;
  final String heroName;
  final String heroInfo;
  final Color color;

  @override
  State<HerosCardWidget> createState() => _HerosCardWidgetState();
}

class _HerosCardWidgetState extends State<HerosCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: widget.key,
      width: widget.deviceSize.width * 0.8,
      height: widget.deviceSize.height * 0.8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: widget.deviceSize.width * 0.8,
              height: widget.deviceSize.height * 0.6,
              decoration: BoxDecoration(
                  color: widget.color, borderRadius: BorderRadius.circular(14)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: widget.deviceSize.height * 0.3,
                      width: widget.deviceSize.width * 0.4,
                      child: Image.asset(
                        widget.heroLogo,
                        fit: BoxFit.contain,
                        //color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.heroName,
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        widget.heroInfo,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 7,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Fourth file (hero_Model.dart)
class HeroModal {
  final String heroLogo;
  final String heroName;
  final String heroInfo;
  final List<String> heroLatestNews;
  final List<String> relatedMovies;

  HeroModal({
    required this.heroLogo,
    required this.heroName,
    required this.heroInfo,
    required this.heroLatestNews,
    required this.relatedMovies,
  });

  factory HeroModal.fromJson(Map<String, dynamic> json) {
    return HeroModal(
      heroLogo: json['heroLogo'],
      heroName: json['heroName'],
      heroInfo: json['heroInfo'],
      heroLatestNews: List<String>.from(json['heroLatestNews']),
      relatedMovies: List<String>.from(json['relatedMovies']),
    );
  }
}
