import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_qu/bloc/pick_date_time/pick_date_time_cubit.dart';
import 'package:schedule_qu/bloc/schedule/add/add_schedule_bloc.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';
import 'package:schedule_qu/pages/widgets/custom_app_bar.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PickDateTimeCubit pickDateTimeBloc = context.read<PickDateTimeCubit>();
    AddScheduleBloc addScheduleBloc = context.read<AddScheduleBloc>();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Schedule'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.purple[50],
          child: Column(
            children: [
              TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  border: UnderlineInputBorder(),
                  filled: true,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  border: UnderlineInputBorder(),
                  filled: true,
                ),
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  BlocListener<PickDateTimeCubit, PickDateTimeState>(
                    bloc: pickDateTimeBloc,
                    listener: (context, state) {
                      timeController.value = TextEditingValue(
                        text: pickDateTimeBloc.getDisplayDateTime(),
                      );
                    },
                    child: TextField(
                      controller: timeController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Date & Time',
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        border: UnderlineInputBorder(),
                        filled: true,
                      ),
                      readOnly: true,
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          pickDateTimeBloc.pickDate(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<AddScheduleBloc, AddScheduleState>(
                      listener: (context, state) {
                        titleController.value =
                            const TextEditingValue(text: '');
                        descController.value = const TextEditingValue(text: '');
                        timeController.value = const TextEditingValue(text: '');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 1),
                            content: Text(state.message),
                          ),
                        );
                      },
                      listenWhen: (previous, current) =>
                          current is AddScheduleSuccess,
                    ),
                    BlocListener<AddScheduleBloc, AddScheduleState>(
                      listener: (context, state) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 1),
                            content: Text(state.message),
                          ),
                        );
                      },
                      listenWhen: (previous, current) =>
                          current is AddScheduleError,
                    )
                  ],
                  child: BlocBuilder<AddScheduleBloc, AddScheduleState>(
                    bloc: addScheduleBloc,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          String title = titleController.text;
                          String desc = descController.text;
                          String pickDateTime = timeController.text;

                          bool isFieldValid = title.isNotEmpty &&
                              desc.isNotEmpty &&
                              pickDateTime.isNotEmpty;

                          ScheduleModel schedule = ScheduleModel(
                            title: title,
                            description: desc,
                            scheduleTime: Timestamp.fromDate(
                              pickDateTimeBloc.getDateTime(),
                            ),
                          );
                          addScheduleBloc.add(
                            SubmitScheduleEvent(schedule, isFieldValid),
                          );
                        },
                        child: Builder(builder: (context) {
                          if (state is AddScheduleLoading) {
                            return const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            );
                          }
                          return const Text('SIMPAN');
                        }),
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
