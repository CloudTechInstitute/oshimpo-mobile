

import 'package:deliveries/appbar.dart';
import 'package:deliveries/model/parcel_model.dart';
import 'package:flutter/material.dart';

class ParcelDetailsScreen extends StatelessWidget {
  final ParcelModel parcelModel;

  const ParcelDetailsScreen({super.key, required this.parcelModel});

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 234, 253),
      appBar: const CustomAppBar(title: 'OSHIMPO'),
      body:Padding(
              padding: const EdgeInsets.all(16.0),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Parcel #',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${parcelModel.parcelNumber}',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Parcel Status',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                parcelModel.parcelStatus.toString(),
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 8),
                      const Text(
                        'Recipient name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        parcelModel.recipientName.toString(),
                        style: const TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Recipient address',
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${parcelModel.recipientAddress}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Recipient number',
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${parcelModel.recipientNumber}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Sender number',
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${parcelModel.senderNumber}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date sent',
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${parcelModel.dateCreated}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Station',
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${parcelModel.inception}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const Text(
                        'ITEMS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text('${parcelModel.items}'),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
