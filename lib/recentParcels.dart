import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveries/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'model/parcel_model.dart';
import 'parcel_detail_screen.dart';
import 'BottomNavBar.dart';

class RecentParcelsScreen extends StatefulWidget {
  final String userId;

  const RecentParcelsScreen({super.key, required this.userId});

  @override
  _RecentParcelsScreenState createState() => _RecentParcelsScreenState();
}

class _RecentParcelsScreenState extends State<RecentParcelsScreen> {
  List<ParcelModel> parcels = [];
  int _currentIndex = 0;


  // Callback for bottom navigation taps
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<QuerySnapshot> fetchParcels() {
    return FirebaseFirestore.instance
        .collection('parcels')
        .where('userId', isEqualTo: widget.userId) // Filter by userId
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: const CustomAppBar(title: 'OSHIMPO'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recent Parcels Heading
            Text(
              'RECENT PARCELS',
              style: GoogleFonts.quicksand(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Display parcels
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: fetchParcels(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No parcels found.'));
                  }

                  List<ParcelModel> parcelList = snapshot.data!.docs.map((doc) {
                    return ParcelModel.fromJson(doc.data() as Map<String, dynamic>);
                  }).toList();

                  return ListView.builder(
                    itemCount: parcelList.length,
                    itemBuilder: (context, index) {
                      final parcel = parcelList[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ParcelDetailsScreen(
                                parcelModel: parcel,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Recipient Name
                                        RichText(
                                          text: TextSpan(
                                            text: 'To: ',
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: parcel.recipientName,
                                                style: GoogleFonts.quicksand(
                                                  textStyle: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.purple,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Parcel Items and Status
                                        RichText(
                                          text: TextSpan(
                                            text: 'Parcel Items ',
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '(${parcel.parcelStatus ?? ''})',
                                                style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                    color: parcel.parcelStatus == 'In transit'
                                                        ? Colors.red
                                                        : Colors.green,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Location
                                        Text(
                                          parcel.recipientAddress ?? 'No address provided',
                                          style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Date
                                    Text(
                                      parcel.dateCreated != null
                                          ? DateFormat('yyyy-MM-dd').format(parcel.dateCreated!)
                                          : 'N/A',
                                      style: GoogleFonts.quicksand(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Use the reusable BottomNavBar component here
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        userId: widget.userId,
      ),
    );
  }
}
