import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_qu/bloc/pick_date_time/pick_date_time_cubit.dart';
import 'package:schedule_qu/pages/widgets/custom_app_bar.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PickDateTimeCubit pickDateTimeBloc = context.read<PickDateTimeCubit>();
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
            ],
          ),
        ),
      ),
    );
  }
}
