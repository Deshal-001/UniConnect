import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uniconnect_app/feature/event/domain/entity/event.dart';
import '../bloc/event_bloc.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(const FetchEvents());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: BlocListener<EventBloc, EventState>(
          listener: (context, state) {
            if (state is EventError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              if (state is EventLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is EventLoaded) {
                if (state.events.isEmpty) {
                  return const Center(child: Text('No events found'));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleTextWidget(title: 'Event List'),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.events.length,
                        itemBuilder: (context, index) {
                          final event = state.events[index];
                          bool isFavorited = false;
                          return index != 0
                              ? Card(
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
                                )
                              : MainEventWidget(event: event, context: context);
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is EventError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return const Center(child: Text('No events found'));
              }
            },
          ),
        ),
      ),
    );
  }
}

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

class TitleTextWidget extends StatelessWidget {
  final String title;
  const TitleTextWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FavoriteIcon extends StatefulWidget {
  final bool initialValue;
  const FavoriteIcon({super.key, this.initialValue = false});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  late bool isFavorited;

  @override
  void initState() {
    super.initState();
    isFavorited = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorited = !isFavorited;
        });
      },
      child: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
        size: 20,
        color: isFavorited ? Colors.red : Colors.grey,
      ),
    );
  }
}
