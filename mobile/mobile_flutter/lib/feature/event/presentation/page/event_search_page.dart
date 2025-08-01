import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: LiquidGlass(
                  shape: const LiquidRoundedSuperellipse(
                      borderRadius: Radius.circular(32)),
                  settings: const LiquidGlassSettings(
                    ambientStrength: 0.7,
                    lightAngle: 0.2 * 3.14,
                    blur: 12,
                    thickness: 28,
                  ),
                  child: TextField(
                    cursorOpacityAnimates: true,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.white70),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Search for events, locations...',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                      filled: false,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value.trim().toLowerCase();
                      });
                      _fetchEvents();
                    },
                  ),
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
                            final location =
                                event.location?.toLowerCase() ?? '';
                            return title.contains(searchText) ||
                                location.contains(searchText);
                          }).toList();

                          if (events.isEmpty) {
                            return const Center(
                                child: Text('No events found.'));
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
      ),
    );
  }
}
