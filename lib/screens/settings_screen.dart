import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  void _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  void _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), elevation: 0),
      body: ListView(
        children: [
          _buildSectionHeader('Appearance'),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Dark Mode'),
            subtitle: Text('Switch between light and dark themes'),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: _toggleTheme,
              activeColor: Colors.red[700],
            ),
          ),
          Divider(),
          _buildSectionHeader('About'),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About MarvelVerse'),
            subtitle: Text('Version 1.0.0'),
            onTap: () => _showAboutDialog(),
          ),
          ListTile(
            leading: Icon(Icons.attribution),
            title: Text('Marvel API Attribution'),
            subtitle: Text('Data provided by Marvel'),
            onTap: () => _showAttributionDialog(),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            onTap: () => _showPrivacyDialog(),
          ),
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text('Contact Support'),
            onTap: () => _showContactDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.red[700],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('About MarvelVerse'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MarvelVerse v1.0.0'),
            SizedBox(height: 8),
            Text('Explore the Marvel Universe like never before.'),
            SizedBox(height: 16),
            Text('Features:'),
            Text('• Browse Marvel characters'),
            Text('• Search and discover'),
            Text('• Bookmark favorites'),
            Text('• Fun facts and trivia'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAttributionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Marvel API Attribution'),
        content: Text(
          'Data provided by Marvel. © 2025 MARVEL\n\n'
          'This app uses the Marvel Comics API to provide character information, images, and related content. '
          'All Marvel characters, names, and related indicia are trademarks of Marvel Entertainment, LLC.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Privacy Policy'),
        content: Text(
          'MarvelVerse respects your privacy:\n\n'
          '• We only store your bookmarked characters locally on your device\n'
          '• No personal information is collected or transmitted\n'
          '• All Marvel data is fetched directly from the official Marvel API\n'
          '• Your preferences are stored locally and never shared',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contact Support'),
        content: Text(
          'Need help or have feedback?\n\n'
          'Email: support@marvelverse.app\n'
          'Website: www.marvelverse.app\n\n'
          'We\'d love to hear from you!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
