import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uniconnect_app/core/providers/event_provider.dart';
import 'package:uniconnect_app/core/widget/title_text.dart';
import '../bloc/event_bloc.dart';
import '../widget/event_widget.dart';
import '../widget/main_event_widget.dart';
import 'package:uniconnect_app/main.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(const FetchEvents());
  }

  void _refreshEvents() {
    context.read<EventBloc>().add(const FetchEvents());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<EventBloc>().add(const FetchEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<EventBloc, EventState>(
          listener: (context, state) {
            if (state is EventError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is EventLoaded) {
              context.read<EventProvider>().setEvents(state.events);
            }
          },
          child: BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              if (state is EventLoading) {
                return Center(
                  child: Lottie.asset(
                    'assets/animations/loadingfinal.json',
                    width: 80,
                    height: 80,
                    fit: BoxFit.scaleDown,
                  ),
                );
              }
              return Consumer<EventProvider>(
                builder: (context, eventProvider, _) {
                  final events = eventProvider.events;
                  if (events.isEmpty) {
                    return const Center(child: Text('No events found'));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleTextWidget(title: 'Event List'),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            _refreshEvents();
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              final event = events[index];
                              final refreshCallback = _refreshEvents;
                              return index != 0
                                  ? EventWidget(
                                      event: event, onRefresh: refreshCallback)
                                  : MainEventWidget(
                                      event: event, onRefresh: refreshCallback);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
