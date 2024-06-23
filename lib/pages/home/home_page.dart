import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_qu/bloc/schedule/delete/delete_schedule_bloc.dart';
import 'package:schedule_qu/bloc/schedule/schedule_bloc.dart';
import 'package:schedule_qu/bloc/schedule/schedule_cubit.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';
import 'package:schedule_qu/pages/home/widget/custom_calendar.dart';

import '../widgets/dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScheduleCubit scheduleCubit = context.read<ScheduleCubit>();
    ScheduleBloc scheduleBloc = context.read<ScheduleBloc>();
    DeleteScheduleBloc delScheduleBloc = context.read<DeleteScheduleBloc>();
    return Scaffold(
      //appBar: const CustomAppBar(),
      body: Column(
        children: [
          BlocBuilder<ScheduleCubit, DateTime>(
            bloc: scheduleCubit,
            builder: (context, state) {
              scheduleBloc.add(GetAllSchedule(state));
              return Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 8,
                  left: 8,
                  right: 8,
                ),
                child: CustomCalendar(
                  focusDate: state,
                  onDaySelected: (selectedDay, focusedDay) {
                    scheduleCubit.setSelectedDate(selectedDay);
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'ScheduleQu',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: MultiBlocListener(
                      listeners: [
                        BlocListener<DeleteScheduleBloc, DeleteScheduleState>(
                          bloc: delScheduleBloc,
                          listener: (context, state) {
                            showLoadingBottomSheet(context);
                          },
                          listenWhen: (previous, current) =>
                              current is DeleteScheduleLoading,
                        ),
                        BlocListener<DeleteScheduleBloc, DeleteScheduleState>(
                          bloc: delScheduleBloc,
                          listener: (context, state) {
                            context.pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(state.message)));
                          },
                          listenWhen: (previous, current) =>
                              current is DeleteScheduleError,
                        ),
                        BlocListener<DeleteScheduleBloc, DeleteScheduleState>(
                          bloc: delScheduleBloc,
                          listener: (context, state) {
                            context.pop();
                            scheduleBloc
                                .add(GetAllSchedule(scheduleCubit.state));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(state.message)));
                          },
                          listenWhen: (previous, current) =>
                              current is DeleteScheduleSuccess,
                        )
                      ],
                      child: BlocBuilder<ScheduleBloc, ScheduleState>(
                        bloc: scheduleBloc,
                        builder: (context, state) {
                          if (state is ScheduleLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is ScheduleError) {
                            return Center(
                              child: Text(state.message),
                            );
                          }
                          if (state.schedules.isEmpty) {
                            return const Center(
                              child: Text('NO DATA'),
                            );
                          }
                          return ListSchedule(
                            schedules: state.schedules,
                            onDeleteClick: (docId) {
                              showAlertDialog(context,
                                  title: 'Hapus Schedule',
                                  message: 'Apakah Anda yakin ingin menghapus?',
                                  onPositiveClick: () {
                                delScheduleBloc
                                    .add(DoDeleteScheduleEvent(docId));
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed('schedule');
        },
        child: const Icon(Icons.event),
      ),
    );
  }
}

class ListSchedule extends StatelessWidget {
  const ListSchedule({
    super.key,
    required this.schedules,
    required this.onDeleteClick,
  });

  final List<ScheduleModel> schedules;
  final Function(String) onDeleteClick;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        ScheduleModel item = schedules[index];
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(item.title),
                subtitle: Text(
                  item.displayScheduleTime,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(item.description),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        onDeleteClick.call(item.docId);
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.goNamed(
                          'edit_schedule',
                          extra: item.toParams(),
                        );
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
