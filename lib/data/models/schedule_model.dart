// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../core/app_configs.dart';

class ScheduleModel extends Equatable {
  final int notifId;
  final String docId;
  final String title;
  final String description;
  final Timestamp scheduleTime;
  final bool repeat;

  const ScheduleModel(
      {this.docId = '',
      required this.notifId,
      required this.title,
      required this.description,
      required this.scheduleTime,
      required this.repeat});

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
      notifId: data['notif_id'],
      title: data['title'],
      description: data['description'],
      scheduleTime: data['schedule_time'],
      repeat: data['repeat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notif_id': notifId,
      'title': title,
      'description': description,
      'schedule_time': scheduleTime,
      'repeat': repeat,
    };
  }

  Map<String, dynamic> toParams() {
    return {
      'id': docId,
      'notif_id': notifId,
      'title': title,
      'description': description,
      'schedule_time': scheduleTime,
      'repeat': repeat,
    };
  }
}
