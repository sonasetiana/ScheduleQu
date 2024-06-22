import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedule_qu/bloc/schedule/schedule_bloc.dart';
import 'package:schedule_qu/bloc/schedule/schedule_cubit.dart';
import 'package:schedule_qu/core/app_configs.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';
import 'package:schedule_qu/pages/home/widget/custom_calendar.dart';

import '../widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScheduleCubit scheduleCubit = context.read<ScheduleCubit>();
    ScheduleBloc scheduleBloc = context.read<ScheduleBloc>();
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
                  top: 24,
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
                        return ListView.builder(
                          itemCount: state.schedules.length,
                          itemBuilder: (context, index) {
                            ScheduleModel item = state.schedules[index];
                            return Card(
                              child: ListTile(
                                title: Text(item.title),
                                subtitle: Text(
                                  DateFormat(
                                    AppConfigs.formatDisplayDateSchedule,
                                    AppConfigs.localId,
                                  ).format(item.scheduleTime.toDate()),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.event),
      ),
    );
  }
}
