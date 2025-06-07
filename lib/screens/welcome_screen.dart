import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red[700]!, Colors.red[900]!],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.explore, size: 100, color: Colors.white),
                      SizedBox(height: 40),
                      Text(
                        'Welcome to MarvelVerse',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Discover legendary characters, iconic comics, and epic storylines from the Marvel Universe.',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      _buildFeatureItem(
                        Icons.person,
                        'Explore Characters',
                        'Browse thousands of Marvel heroes and villains',
                      ),
                      SizedBox(height: 20),
                      _buildFeatureItem(
                        Icons.book,
                        'Discover Comics',
                        'Find your favorite comics and storylines',
                      ),
                      SizedBox(height: 20),
                      _buildFeatureItem(
                        Icons.bookmark,
                        'Save Favorites',
                        'Bookmark characters and comics you love',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
