import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/event_provider.dart';
import '../../../../core/widget/title_text.dart';
import '../bloc/event_bloc.dart';
import '../widget/event_widget.dart';

class BookedEventPage extends StatefulWidget {
  const BookedEventPage({super.key});

  @override
  State<BookedEventPage> createState() => _BookedEventPageState();
}

class _BookedEventPageState extends State<BookedEventPage> {
  static const userId = 53;

  @override
  void initState() {
    super.initState();
    Logger().e("init state");
    context
        .read<EventBloc>()
        .add(const FindBookedEventsByUserId(userId: userId));
  }

  Future<void> _refreshBookedEvents() async {
    context
        .read<EventBloc>()
        .add(const FindBookedEventsByUserId(userId: userId));
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleTextWidget(title:'Booked Events'),
            Expanded(
              child: BlocListener<EventBloc, EventState>(
                listener: (context, state) {
                  if (state is FindBookedEventsByUserIdSuccess) {
                    context.read<EventProvider>().setBookedEvents(state.events);
                  }
                },
                child: BlocBuilder<EventBloc, EventState>(
                  builder: (context, state) {
                    if (state is FindBookedEventsByUserIdLoading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/animations/loadingfinal.json',
                          width: 80,
                          height: 80,
                          fit: BoxFit.scaleDown,
                        ),
                      );
                    }
                    if (state is FindBookedEventsByUserIdError) {
                      return Center(child: Text(state.message));
                    }
                    return Consumer<EventProvider>(
                      builder: (context, eventProvider, _) {
                        final events = eventProvider.bookedEvents;
                        if (events.isEmpty) {
                          return const Center(
                              child: Text('No booked events found.'));
                        }
                        return RefreshIndicator(
                          onRefresh: _refreshBookedEvents,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ListView.builder(
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                final event = events[index];
                                return EventWidget(
                                  event: event,
                                  onRefresh: _refreshBookedEvents,
                                  navigatingFromBooked: true,
                                );
                              },
                            ),
                          ),
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
