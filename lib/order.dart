import 'package:deliveries/appbar.dart';
import 'package:deliveries/bottomNavbar.dart';
import 'package:deliveries/model/parcel_model.dart';
import 'package:deliveries/recentParcels.dart';
import 'package:deliveries/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For Google Fonts
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert';

class OrderScreen extends StatefulWidget {
  final String userId;

  const OrderScreen({super.key, required this.userId});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _currentIndex = 1; // Default to the 'Send Parcel' tab

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController recipientNameController = TextEditingController();
  final TextEditingController recipientNumberController = TextEditingController();
  final TextEditingController recipientAddressController = TextEditingController();
  final TextEditingController senderNameController = TextEditingController();
  final TextEditingController senderNumberController = TextEditingController();
  final TextEditingController senderAddressController = TextEditingController();
  final TextEditingController itemDetailsController = TextEditingController();

  String get currentUserId {
    final User? userId = FirebaseAuth.instance.currentUser;
    return userId?.uid ?? ''; // Return the current user's ID or an empty string if the user is not logged in
  }

  Future<void> _placeOrder() async {
    print("pig");
    // Collect data from controllers
    final from = fromController.text;
    final to = toController.text;
    final recipientName = recipientNameController.text;
    final recipientNumber = recipientNumberController.text;
    final recipientAddress = recipientAddressController.text;
    final senderName = senderNameController.text;
    final senderNumber = senderNumberController.text;
    final senderAddress = senderAddressController.text;
    final itemDetails = itemDetailsController.text;

    final parcel = ParcelModel(
      inception: from,
      destination: to,
      recipientName: recipientName,
      recipientNumber: recipientNumber,
      recipientAddress: recipientAddress,
      senderName: senderName,
      senderNumber: senderNumber,
      senderAddress: senderAddress,
      items: itemDetails,
    );
    await FirebaseServices().addParcel(parcel);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate to the appropriate screen based on the selected tab
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => RecentParcelsScreen(userId: currentUserId)),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => OrderScreen(userId: currentUserId)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'OSHIMPO'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'SEND PARCEL',
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // From and To Fields
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: fromController,
                      decoration: InputDecoration(
                        labelText: 'From',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: toController,
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Recipient Name
              TextField(
                controller: recipientNameController,
                decoration: InputDecoration(
                  labelText: 'Recipient name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Recipient Number
              TextField(
                controller: recipientNumberController,
                decoration: InputDecoration(
                  labelText: 'Recipient number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Recipient Address
              TextField(
                controller: recipientAddressController,
                decoration: InputDecoration(
                  labelText: 'Recipient address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Sender Name
              TextField(
                controller: senderNameController,
                decoration: InputDecoration(
                  labelText: 'Sender name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Sender Number
              TextField(
                controller: senderNumberController,
                decoration: InputDecoration(
                  labelText: 'Sender number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Sender Address
              TextField(
                controller: senderAddressController,
                decoration: InputDecoration(
                  labelText: 'Sender address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Item Details
              TextField(
                controller: itemDetailsController,
                decoration: InputDecoration(
                  labelText: 'Enter items separated by a comma (e.g., TV, Shoes, Dresses)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Place Order Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    fixedSize: const Size(380, 50),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Place order',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        userId: widget.userId,
      ),
    );
  }
}
