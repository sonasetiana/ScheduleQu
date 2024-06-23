// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../core/app_configs.dart';

class ScheduleModel extends Equatable {
  final String docId;
  final String title;
  final String description;
  final Timestamp scheduleTime;

  const ScheduleModel({
    this.docId = '',
    required this.title,
    required this.description,
    required this.scheduleTime,
  });

  @override
  List<Object> get props => [title, description, scheduleTime];

  String get displayScheduleTime => DateFormat(
        AppConfigs.formatDisplayDateSchedule,
        AppConfigs.localId,
      ).format(scheduleTime.toDate());

  factory ScheduleModel.fromCollection(
      String docId, Map<String, dynamic> data) {
    return ScheduleModel(
      docId: docId,
      title: data['title'],
      description: data['description'],
      scheduleTime: data['schedule_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'schedule_time': scheduleTime,
    };
  }

  Map<String, dynamic> toParams() {
    return {
      'id': docId,
      'title': title,
      'description': description,
      'schedule_time': scheduleTime,
    };
  }
}
