import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniconnect_app/core/widget/title_text.dart';
import '../bloc/event_bloc.dart';
import '../widget/event_widget.dart';
import '../widget/main_event_widget.dart';

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
                          return index != 0
                              ? EventWidget(event: event)
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



