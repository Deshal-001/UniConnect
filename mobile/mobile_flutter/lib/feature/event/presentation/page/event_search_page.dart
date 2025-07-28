import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/event_provider.dart';
import '../bloc/event_bloc.dart';
import '../widget/event_widget.dart';

class EventSearchPage extends StatefulWidget {
  const EventSearchPage({super.key});

  @override
  State<EventSearchPage> createState() => EventSearchPageState();
}

class EventSearchPageState extends State<EventSearchPage> {
  String searchText = '';

  void _fetchEvents() {
    context.read<EventBloc>().add(const FetchEvents());
  }

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                cursorOpacityAnimates: true,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Search For..',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value.trim().toLowerCase();
                  });
                  // Fetch events when searching
                  _fetchEvents();
                },
              ),
            ),
            Expanded(
              child: BlocListener<EventBloc, EventState>(
                listener: (context, state) {
                  if (state is EventLoaded) {
                    context.read<EventProvider>().setEvents(state.events);
                  }
                },
                child: BlocBuilder<EventBloc, EventState>(
                  builder: (context, state) {
                    if (state is EventLoading) {
                      return Lottie.asset(
                        'assets/animations/loadingfinal.json',
                        width: 80,
                        height: 80,
                        fit: BoxFit.scaleDown,
                      );
                    }
                    if (state is EventError) {
                      return Center(child: Text(state.message));
                    }
                    return Consumer<EventProvider>(
                      builder: (context, eventProvider, _) {
                        final events = eventProvider.events.where((event) {
                          final title = event.title?.toLowerCase() ?? '';
                          final location = event.location?.toLowerCase() ?? '';
                          return title.contains(searchText) ||
                              location.contains(searchText);
                        }).toList();

                        if (events.isEmpty) {
                          return const Center(child: Text('No events found.'));
                        }

                        return ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            final event = events[index];
                            return EventWidget(
                              event: event,
                              onRefresh: _fetchEvents,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
