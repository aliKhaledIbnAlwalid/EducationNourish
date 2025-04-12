import 'package:edunourish/Student_Interface/List/My_Class_Schedule.dart';
import 'package:edunourish/Teacher_Interface/Home/home_teacher.dart';
import 'package:flutter/material.dart';

import '../List/drawer_page_teacher.dart';
import 'Settings.dart';

class BtmNavBarTeacher extends StatefulWidget {
  const BtmNavBarTeacher({super.key});

  @override
  State<BtmNavBarTeacher> createState() => _BtmNavBarTeacherState();
}

class _BtmNavBarTeacherState extends State<BtmNavBarTeacher> {
  int _selectedIndex = 2;

  void _navigateBottomBar(int index) {
    if (index == 4) {
      _showSettingsModal();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: const SettingsPage(),
      ),
    );
  }


  final List<Widget> _pages = [
    const DrawerPageTeacher(),
    MyClassSchedule(),
    const HomeTeacher(),
    const DrawerPageTeacher(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _selectedIndex < 1
            ? _pages[_selectedIndex]
            : _pages[_selectedIndex - 0],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:  const Color(0xff98afb0),
          elevation: 0,
          selectedLabelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold), // Increase selected label size
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
          ), 
          onTap: _navigateBottomBar,
          currentIndex: _selectedIndex,
         selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.view_list_rounded,
                size: 25,
              ),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.table_view_rounded,
                size: 25,
              ),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 25,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.sports_gymnastics_rounded,
                size: 25,
              ),
              label: 'Activities',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_rounded,
                size: 25,
              ),
              label: 'Settings',
            ),
          ],
        ));
  }
}
