import 'package:flutter/material.dart';
import 'package:schedule_qu/pages/widgets/custom_app_bar.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tambah Schedule'),
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
              TextField(
                controller: timeController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  border: UnderlineInputBorder(),
                  filled: true,
                ),
                readOnly: true,
                autofocus: false,
                onTapAlwaysCalled: true,
                onTap: () {
                  print('ok');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
