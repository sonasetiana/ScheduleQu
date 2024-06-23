// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_qu/bloc/pick_date_time/pick_date_time_cubit.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';
import 'package:schedule_qu/pages/widgets/custom_app_bar.dart';

import '../../../bloc/schedule/edit/edit_schedule_bloc.dart';
import '../../../bloc/schedule/schedule_cubit.dart';

class EditSchedulePage extends StatelessWidget {
  EditSchedulePage({
    super.key,
    required this.extraSchedule,
  });
  final ScheduleModel extraSchedule;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  Future<bool> _onWillPop(BuildContext context) async {
    // Lakukan sesuatu ketika tombol back ditekan
    print("Back button pressed");
    ScheduleCubit cubit = context.read<ScheduleCubit>();
    cubit.setSelectedDate(DateTime.now());
    return true; // return true untuk memungkinkan pop, return false untuk mencegah pop
  }

  @override
  Widget build(BuildContext context) {
    PickDateTimeCubit pickDateTimeBloc = context.read<PickDateTimeCubit>();
    EditScheduleBloc editScheduleBloc = context.read<EditScheduleBloc>();

    //init data controller
    titleController.value = TextEditingValue(text: extraSchedule.title);
    descController.value = TextEditingValue(text: extraSchedule.description);
    timeController.value =
        TextEditingValue(text: extraSchedule.displayScheduleTime);

    pickDateTimeBloc.init(extraSchedule.scheduleTime);

    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Edit Schedule'),
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
                      BlocListener<EditScheduleBloc, EditScheduleState>(
                        bloc: editScheduleBloc,
                        listener: (context, state) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 1),
                              content: Text(state.message),
                            ),
                          );
                        },
                        listenWhen: (previous, current) =>
                            current is EditScheduleSuccess,
                      ),
                      BlocListener<EditScheduleBloc, EditScheduleState>(
                        bloc: editScheduleBloc,
                        listener: (context, state) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 1),
                              content: Text(state.message),
                            ),
                          );
                        },
                        listenWhen: (previous, current) =>
                            current is EditScheduleError,
                      )
                    ],
                    child: BlocBuilder<EditScheduleBloc, EditScheduleState>(
                      bloc: editScheduleBloc,
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
                                docId: extraSchedule.docId,
                                notifId: extraSchedule.notifId,
                                title: title,
                                description: desc,
                                scheduleTime: Timestamp.fromDate(
                                  pickDateTimeBloc.getDateTime(),
                                ),
                                repeat: extraSchedule.repeat);
                            editScheduleBloc.add(
                              SubmitEditScheduleEvent(schedule, isFieldValid),
                            );
                          },
                          child: Builder(builder: (context) {
                            if (state is EditScheduleLoading) {
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
      ),
    );
  }
}
