import 'package:cloud_firestore/cloud_firestore.dart';

class ParcelModel {
  final String? userId;
  final String? parcelNumber;
  final String? parcelStatus;
  final String? inception;
  final String? destination;
  final String? recipientName;
  final String? recipientNumber;
  final String? recipientAddress;
  final String? senderName;
  final String? senderNumber;
  final String? senderAddress;
  final String? items;
  final DateTime? dateCreated;

  ParcelModel({
    this.userId,
    this.parcelNumber,
    this.parcelStatus,
    this.inception,
    this.destination,
    this.recipientName,
    this.recipientNumber,
    this.recipientAddress,
    this.senderName,
    this.senderNumber,
    this.senderAddress,
    this.items,
    this.dateCreated,
  });

  factory ParcelModel.fromJson(Map<String, dynamic> json) {
    return ParcelModel(
      userId: json['userId'],
      parcelNumber: json['parcelNumber'],
      parcelStatus: json['parcelStatus'],
      inception: json['inception'],
      destination: json['destination'],
      recipientName: json['recipientName'],
      recipientNumber: json['recipientNumber'],
      recipientAddress: json['recipientAddress'],
      senderName: json['senderName'],
      senderNumber: json['senderNumber'],
      senderAddress: json['senderAddress'],
      items: json['items'],
      // Convert Firestore Timestamp to DateTime
      dateCreated: json['dateCreated'] != null
          ? (json['dateCreated'] as Timestamp).toDate()
          : null,
    );
  }

  factory ParcelModel.fromMap(Map<String, dynamic> map) {
    return ParcelModel(
      userId: map['userId'],
      parcelNumber: map['parcelNumber'],
      parcelStatus: map['parcelStatus'],
      inception: map['inception'],
      destination: map['destination'],
      recipientName: map['recipientName'],
      recipientNumber: map['recipientNumber'],
      recipientAddress: map['recipientAddress'],
      senderName: map['senderName'],
      senderNumber: map['senderNumber'],
      senderAddress: map['senderAddress'],
      items: map['items'],
      // Convert Firestore Timestamp to DateTime
      dateCreated: map['dateCreated'] != null
          ? (map['dateCreated'] as Timestamp).toDate()
          : null,
    );
  }
}
