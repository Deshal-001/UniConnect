import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

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
      backgroundColor: const Color(0xFF032343),
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
                    LiquidGlass(
                      shape: const LiquidRoundedSuperellipse(borderRadius: Radius.circular(0)),
                      settings:  const LiquidGlassSettings(
                        ambientStrength: 0.7,
                        lightAngle: 0.2 * 3.14,
                        // glassColor: Colors.white.withOpacity(0.10),
                        blur: 12,
                        thickness: 28,
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          // bottomLeft: Radius.circular(32),
                          // bottomRight: Radius.circular(32),
                        ),
                        child: Image.asset(
                          event.imgUrl ?? 'assets/images/img1.jpg',
                          fit: BoxFit.cover,
                          height: 300,
                          width: double.infinity,
                          
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 80,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black54,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 32,
                      left: 24,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.greenAccent.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today_rounded, size: 15, color: Colors.white),
                            const SizedBox(width: 5),
                            Text(
                              event.date != null
                                  ? DateFormat('EEE, MMM d · HH:mm a').format(event.date!)
                                  : 'No Date',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 42,
                      right: 24,
                      child: Row(
                        children: [
                          Material(
                            color: Colors.black.withOpacity(0.65),
                            elevation: 2,
                            shape: const CircleBorder(),
                            child: IconButton(
                              icon: const Icon(Icons.favorite_border, color: Colors.redAccent, size: 22),
                              onPressed: () {
                              },
                              tooltip: 'Like',
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Material(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.65),
                            elevation: 2,
                            shape: const CircleBorder(),
                            child: IconButton(
                              icon: const Icon(Icons.share_outlined, color: Colors.white, size: 20),
                              onPressed: () {
                              },
                              tooltip: 'Share',
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 42,
                      left: 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 10, right: 10),
                    child: LiquidGlass(
                      shape: const LiquidRoundedSuperellipse(borderRadius: Radius.circular(32)),
                      settings: const LiquidGlassSettings(
                        // ambientStrength: 0.7,
                        lightAngle: 0.2 * 3.14,
                        // glassColor: Colors.white.withOpacity(0.10),
                        blur: 12,
                        thickness: 18,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF032343),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  event.title ?? 'No Title',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on_rounded, color: Colors.white70, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        event.location ?? 'No Location',
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if ((event.universityName ?? '').isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                                  child: Text(
                                    event.universityName!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 28),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'About',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      event.description ?? 'No Description',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 28),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rules and Regulations',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '1. Respect all members of the university community.\n\n'
                                      '2. Use your real identity and do not impersonate others.\n\n'
                                      '3. Do not post or share inappropriate or offensive content.\n\n'
                                      '4. Follow all university policies and event guidelines.\n\n'
                                      '5. Report any suspicious or harmful activity to the administration.',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 36),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 32.0),
                  child: CustomButton(
                    enable: !(widget.navigatingFromBooked ?? false),
                    isLoading: glassyLoading,
                    text: 'RSVP',
                    onPressed: () {
                      context
                          .read<EventBloc>()
                          .add(BookEvent(eventId: event.id ?? 0));
                    },
                    borderRadius: 12,
                    height: 52,
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