import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Event {
  final int id;
  final String title;
  final String label;
  final String publishDate;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.title,
    required this.label,
    required this.publishDate,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as int,
      title: json['title'] as String,
      label: json['label'] as String,
      publishDate: json['publish_date'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class EventProvider extends ChangeNotifier {
  List<Event> _events = [];
  List<Event> get events => _events;

  Future<void> fetchEvents() async {
    final response = await http.get(
        Uri.parse('https://moto-play.visualmigration.com/public/api/events'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      _events = jsonData.map((json) => Event.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load blogs');
    }
  }
}