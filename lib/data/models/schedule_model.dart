// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ScheduleModel extends Equatable {
  final String title;
  final String description;
  final Timestamp scheduleTime;
  final String colorType;

  const ScheduleModel({
    required this.title,
    required this.description,
    required this.scheduleTime,
    required this.colorType,
  });

  @override
  List<Object> get props => [title, description, scheduleTime, colorType];

  factory ScheduleModel.fromJson(Map<String, dynamic> data) {
    return ScheduleModel(
      title: data['title'],
      description: data['description'],
      scheduleTime: data['schedule_time'],
      colorType: data['color_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'schedule_time': scheduleTime,
      'color_type': colorType,
    };
  }
}
