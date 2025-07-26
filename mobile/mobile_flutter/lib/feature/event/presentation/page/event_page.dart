import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widget/custom_button.dart';
import '../../domain/entity/event.dart';

class EventPage extends StatefulWidget {
  final Event event;
  const EventPage({super.key, required this.event});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    return Scaffold(
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/img1.jpg',
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  event.title ?? 'No Title',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.black, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      event.date != null
                          ? DateFormat('EEE, MMM d · HH:mm a').format(event.date!)
                          : 'No Date',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: Colors.black, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          event.location ?? 'No Location',
                          maxLines: 5,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Text(
                      event.universityName ?? '',
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event.description ?? 'No Description',
                      style: const TextStyle(fontSize: 13, color: Colors.black,
          
                          ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
            child: CustomButton(
              text: 'RSVP',
              onPressed: () {
                // Handle join event action
              },
              
              borderRadius: 8,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
