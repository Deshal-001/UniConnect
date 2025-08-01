import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../../domain/entity/event.dart';
import '../page/event_page.dart';

class MainEventWidget extends StatelessWidget {
  const MainEventWidget({
    super.key,
    required this.event,
    required this.onRefresh,
  });

  final Event event;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .push(
          MaterialPageRoute(
            builder: (_) => EventPage(event: event),
          ),
        )
            .then((result) {
          if (result != null) onRefresh();
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: LiquidGlass(
          shape: const LiquidRoundedSuperellipse(
              borderRadius: Radius.circular(20)),
          settings: LiquidGlassSettings(
            ambientStrength: 0.8,
            lightAngle: 0.3 * math.pi,
            glassColor: Colors.black.withOpacity(0.10),
            blur: 18,
            thickness: 28,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Event image with overlay gradient, date badge, and visible like/share buttons
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        event.imgUrl ?? 'assets/images/img1.jpg',
                        fit: BoxFit.cover,
                        height: 170,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 60,
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
                    // Date badge on image (top left)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_rounded,
                                size: 14, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              event.date != null
                                  ? DateFormat('MMM d').format(event.date!)
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
                    // Like & Share buttons on image (top right) with high visibility
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Row(
                        children: [
                          Material(
                            color: Colors.black.withOpacity(0.4),
                            elevation: 2,
                            shape: const CircleBorder(),
                            child: IconButton(
                              icon: const Icon(Icons.favorite_border,
                                  color: Colors.redAccent, size: 20),
                              onPressed: () {
                              },
                              tooltip: 'Like',
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 36, minHeight: 36),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Material(
                            color: Colors.black.withOpacity(0.4),
                            elevation: 2,
                            shape: const CircleBorder(),
                            child: IconButton(
                              icon: const Icon(Icons.share_outlined,
                                  color: Colors.white, size: 18),
                              onPressed: () {
                                // TODO: Implement share
                              },
                              tooltip: 'Share',
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 36, minHeight: 36),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Title
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                  child: Text(
                    event.title ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 16,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          event.location ?? 'No Location',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
