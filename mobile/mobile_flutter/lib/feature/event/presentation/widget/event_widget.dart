import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widget/fav_icon.dart';
import '../../domain/entity/event.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        margin:
            const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Image.asset(
                  'assets/images/img2.jpg',
                  fit: BoxFit.cover,
                  height: 90,
                  width: 90,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.date != null
                          ? DateFormat(
                                  'EEE, MMM d · HH:mm a')
                              .format(event.date!)
                          : 'No Date',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event.title ?? 'No Title',
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 4.0),
                      child: Row(
                        children: [
                          const Icon(
                              Icons
                                  .location_on_outlined,
                              size: 13,
                              color: Colors.black54),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.location ??
                                  'No Location',
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow
                                  .ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight:
                                    FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end,
                  children: [
                    FavoriteIcon(),
                    SizedBox(width: 12),
                    Icon(Icons.share_outlined,
                        size: 18, color: Colors.grey),
                  ],
                )),
          ],
        ),
      );
  }
}