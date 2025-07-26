import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widget/fav_icon.dart';
import '../../domain/entity/event.dart';

class MainEventWidget extends StatelessWidget {
  const MainEventWidget({
    super.key,
    required this.event,
    required this.context,
  });

  final Event event;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.01,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              'assets/images/img1.jpg',
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
            child: Text(
              event.date != null
                  ? DateFormat('EEE, MMM d · HH:mm a').format(event.date!)
                  : 'No Date',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            child: Text(
              event.title ?? 'No Title',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 2),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Text(event.location ?? 'No Location',
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      )),
                ),
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FavoriteIcon(),
                  SizedBox(width: 12),
                  Icon(Icons.share_outlined, size: 18, color: Colors.grey),
                ],
              )),
        ],
      ),

      // ListTile(
      //   title: Text(event.title ?? 'No Title'),
      //   subtitle: Text(event.description ?? 'No Description'),
      // ),
    );
  }
}




