import 'package:edunourish/Student_Interface/List/Class_Schedule_student.dart';
import 'package:flutter/material.dart';
import '../List/drawer_page.dart';
import '../Home/home_student.dart';
import 'Activities.dart';
import 'Settings_student.dart';

class BtmNavBarStudent extends StatefulWidget {
  const BtmNavBarStudent({super.key});

  @override
  State<BtmNavBarStudent> createState() => _BtmNavBarStudentState();
}

class _BtmNavBarStudentState extends State<BtmNavBarStudent> {
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
        child: const SettingsStudent(),
      ),
    );
  }


  final List<Widget> _pages = [
    const DrawerPage(),
    ClassScheduleStudent(),
    const HomeStudent(),
     Activities(),
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
