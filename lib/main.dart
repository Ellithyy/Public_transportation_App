import 'package:flutter/material.dart';
import 'package:public_tranport_app/constants.dart';
import 'package:public_tranport_app/screens/login.dart';
import 'package:public_tranport_app/screens/home_screen.dart';
import 'package:public_tranport_app/screens/map_screen.dart';
import 'package:public_tranport_app/screens/profile_screen.dart';

void main() => runApp(
  MaterialApp(
    home: SplashScreen(), // Set SplashScreen as the initial screen
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'OpenSans'),
  ),
);

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;

  final List<Widget> _screens = [Home(), Profile(),MapScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMoonStones,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedFontSize: 12, // Maintain minimal font size for a modern look
        elevation: 5.0, // Slight elevation for a clean shadow effect
        selectedItemColor: kMoonStones,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 0
                  ? 'assets/icons/home_colored.png'
                  : 'assets/icons/home.png',
              width: 25,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 1
                  ? 'assets/icons/profile_colored.png'
                  : 'assets/icons/profile.png',
              width: 25,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 2
                  ? 'assets/icons/map_colored.png'
                  : 'assets/icons/map.png',
              width: 25,
            ),
            label: 'Map',
          ),
        ],
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate loading time and navigate to the Login screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()), // Corrected the class name to LoginScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMoonStones, // Unified color scheme
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Image.asset(
              'assets/images/3lqlxlh5.png', // Path to your logo
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            // App name
            Text(
              'Public Transport App',
              style: TextStyle(
                fontSize: 28, // Larger font for better readability
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            // Loading spinner
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20),
            // Loading text
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
