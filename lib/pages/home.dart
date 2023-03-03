import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:doctor_app/pages/settings.dart';
import 'package:doctor_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'AppointmentsPage.dart';
import 'doctor_page.dart';
import 'home_page.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _pages = [HomePage(), AppointmentsPage(), DoctorPage(), SettingsPage()];

  int _currentIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: _pages
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            activeColor: primary,
            inactiveColor: Colors.lightBlue,
            title: Text('Home'),
            icon: Icon(Icons.home)
          ),
          BottomNavyBarItem(
              activeColor: primary,
              inactiveColor: Colors.lightBlue,
              title: Text('Bookings'),
              icon: Icon(Icons.event_note_rounded)
          ),
          BottomNavyBarItem(
            activeColor: primary,
            inactiveColor: Colors.lightBlue,
            title: Text('Doctors'),
            icon: Icon(Icons.medical_services_rounded)
          ),

          BottomNavyBarItem(
            activeColor: primary,
            inactiveColor: Colors.lightBlue,
            title: Text('Settings'),
            icon: Icon(Icons.settings)
          ),
        ],
      ),
    );
  }

}