import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      elevation: 0,
      title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.logout),
          onPressed: () {
            // Add logout functionality here
            _showLogoutDialog(context); // Example: show a confirmation dialog
          },
        ),
      ],
    );
  }

  // Function to show a confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout operation here
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacementNamed('/login'); // Navigate to login page (example)
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
