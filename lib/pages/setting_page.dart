import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          // Profile Section
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              backgroundImage: const NetworkImage(
                  "https://via.placeholder.com/150"), // Replace with actual profile image
            ),
            title: const Text(
              "Phillip Franci",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: const Text("phillip@example.com"),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Navigate to Profile Edit Screen
              },
            ),
          ),
          const Divider(),

          // General Settings Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              "General",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          _buildSettingsOption(
            context,
            icon: Icons.notifications,
            title: "Notifications",
            onTap: () {
              // Navigate to Notifications settings
            },
          ),
          _buildSettingsOption(
            context,
            icon: Icons.language,
            title: "Language",
            onTap: () {
              // Show Language Selection Dialog
            },
          ),
          _buildSettingsOption(
            context,
            icon: Icons.privacy_tip,
            title: "Privacy Policy",
            onTap: () {
              // Open Privacy Policy
            },
          ),
          _buildSettingsOption(
            context,
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: () {
              // Navigate to Help & Support screen
            },
          ),
          const Divider(),

          // Account Settings Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              "Account",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          _buildSettingsOption(
            context,
            icon: Icons.password,
            title: "Change Password",
            onTap: () {
              // Navigate to Change Password screen
            },
          ),
          _buildSettingsOption(
            context,
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  // Widget to build individual settings option
  Widget _buildSettingsOption(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  // Logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Navigate back to login screen
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
