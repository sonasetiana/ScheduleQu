import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:schedule_qu/app_routes.dart';
import 'package:schedule_qu/data/models/schedule_model.dart';

import '../../core/app_configs.dart';

showAlertDialog(
  BuildContext context, {
  String title = '',
  String message = '',
  String titleNegButton = 'Tidak',
  String titlePosButton = 'Ya',
  bool visibleNegativeButton = true,
  VoidCallback? onNegativeClick,
  VoidCallback? onPositiveClick,
}) {
  // set up the button
  Widget negativeButton = Visibility(
    visible: visibleNegativeButton,
    child: TextButton(
      child: Text(titleNegButton),
      onPressed: () {
        onNegativeClick?.call();
        Navigator.pop(context);
      },
    ),
  );

  Widget positiveButton = TextButton(
    child: Text(titlePosButton),
    onPressed: () {
      onPositiveClick?.call();
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      negativeButton,
      positiveButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showDetailBottomSheet(
  BuildContext context,
  ScheduleModel schedule,
) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  schedule.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            Text(
              DateFormat(
                AppConfigs.formatDisplayDateSchedule,
                AppConfigs.localId,
              ).format(schedule.scheduleTime.toDate()),
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              schedule.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Menutup BottomSheetDialog
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
                    Navigator.pop(context); // Menutup BottomSheetDialog
                    // Logika untuk mengedit
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Edit tapped')),
                    );
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
