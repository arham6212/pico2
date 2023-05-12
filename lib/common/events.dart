import 'package:pico2/models/user.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';

final EventBus eventBus = EventBus();

class EventShowLoading {
  const EventShowLoading();
}

class EventCloseLoading {
  const EventCloseLoading();
}

class EventUserLogin {
  const EventUserLogin();
}

class EventUserLogout {
  final User user;
  const EventUserLogout(this.user);
}

class EventErrorSheet {
  final String message;
  const EventErrorSheet({required this.message});
}

class EventAlertSheet {
  final String title;
  final Function onPreceed;
  final BuildContext context;
  const EventAlertSheet(
      {required this.title, required this.onPreceed, required this.context});
}

class EventPreviewWidget {
  final int previewIndex;
  final bool isPreviewing;

  const EventPreviewWidget(this.previewIndex, this.isPreviewing);
}

class UserLoggedInEvent {
  UserLoggedInEvent();
}
