// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:motplay/models/event_model.dart';

class EventApiDetailScreen extends StatelessWidget {
  Event event;
  EventApiDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: HtmlWidget(event.description),
      ),
    );
  }
}
