import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_button.dart';
import '../../domain/entity/event.dart';
import '../bloc/event_bloc.dart';

// ignore: must_be_immutable
class EventPage extends StatefulWidget {
  final Event event;
  bool? navigatingFromBooked;
  EventPage({
    super.key,
    required this.event,
    this.navigatingFromBooked = false,
  });

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool glassyLoading = false;

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    return Scaffold(
      body: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is BookingLoading) {
            setState(() {
              glassyLoading = true;
            });
          } else if (state is BookingSuccess) {
            setState(() {
              glassyLoading = true;
            });
            CustomAlert.showSuccess(context).then((value) {
              setState(() {
                glassyLoading = false;
              });
              Navigator.of(context).pop(true);
            });
          } else if (state is BookingError) {
            setState(() {
              glassyLoading = true;
            });
            CustomAlert.showError(context, state.statusCode).then((value) {
              setState(() {
                glassyLoading = false;
              });
            });
          }
        },
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      event.imgUrl ?? 'assets/images/img1.jpg',
                      fit: BoxFit.cover,
                      height: 300,
                      width: double.infinity,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            event.title ?? 'No Title',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Colors.black, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                event.date != null
                                    ? DateFormat('EEE, MMM d · HH:mm a')
                                        .format(event.date!)
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
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
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
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Rules and Regulations',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '1. Respect all members of the university community.\n\n'
                                '2. Use your real identity and do not impersonate others.\n\n'
                                '3. Do not post or share inappropriate or offensive content.\n\n'
                                '4. Follow all university policies and event guidelines.\n\n'
                                '5. Report any suspicious or harmful activity to the administration.',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 40.0),
                  child: CustomButton(
                    enable: !(widget.navigatingFromBooked ?? false),
                    isLoading: glassyLoading,
                    text: 'RSVP',
                    onPressed: () {
                      context
                          .read<EventBloc>()
                          .add(BookEvent(eventId: event.id ?? 0));
                    },
                    borderRadius: 8,
                    height: 50,
                  ),
                ),
              ],
            ),
            if (glassyLoading)
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
