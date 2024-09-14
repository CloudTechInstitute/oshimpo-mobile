import 'package:deliveries/order.dart';
import 'package:deliveries/RecentParcels.dart'; // Make sure the path is correct
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String userId;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white, // Color of the selected item
      unselectedItemColor: Colors.white54,
      backgroundColor: Colors.purple,
      currentIndex: currentIndex,
      onTap: (index) {
        // Call the onTap function to handle navigation
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RecentParcelsScreen(userId: userId),
            ),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OrderScreen(userId: userId),
            ),
          );
        }
        onTap(index); // Also trigger the onTap callback
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.send, color: Colors.white),
          label: 'Send Parcel',
        ),
      ],
    );
  }
}
