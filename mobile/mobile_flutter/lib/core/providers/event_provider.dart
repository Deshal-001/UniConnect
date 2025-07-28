import 'package:flutter/material.dart';

import '../../feature/event/domain/entity/event.dart';

class EventProvider extends ChangeNotifier {
  List<Event> _events = [];
  List<Event> _bookedEvents = [];
  List<Event> get events => _events;
  List<Event> get bookedEvents => _bookedEvents;

  void setEvents(List<Event> events) {
    _events = events;
    notifyListeners();
  }

  void setBookedEvents(List<Event> bookedEvents) {
    _bookedEvents = bookedEvents;
    notifyListeners();
  }
  }


