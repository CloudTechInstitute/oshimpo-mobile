import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveries/model/parcel_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addParcel(ParcelModel parcelModel) async {
    try {
      // Get the current user's ID
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      Random random = new Random();
      int randomNumber = random.nextInt(1000);
      await db.collection('parcels').add({
        'userId': user.uid,
        'parcelNumber': 'A-00$randomNumber',
        'parcelStatus': 'taken',
        'inception': parcelModel.inception,
        'destination': parcelModel.destination,
        'recipientName': parcelModel.recipientName,
        'recipientNumber': parcelModel.recipientNumber,
        'recipientAddress': parcelModel.recipientAddress,
        'senderName': parcelModel.senderName,
        'senderAddress': parcelModel.senderAddress,
        'senderNumber': parcelModel.senderNumber,
        'items': parcelModel.items,
        'dateCreated': DateTime.now(),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
