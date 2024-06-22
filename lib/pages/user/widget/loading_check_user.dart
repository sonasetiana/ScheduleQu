import 'package:flutter/material.dart';
import 'package:schedule_qu/bloc/user/user_bloc.dart';

class LoadingCheckUser extends StatelessWidget {
  const LoadingCheckUser({
    super.key,
    required this.state,
  });

  final UserState state;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: state is UserLoading || state is UserSuccess,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(4),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              String message = 'Checking your username...';
              if (state is UserSuccess) {
                message = state.message;
              }
              return Text(
                message,
                style: const TextStyle(
                  color: Colors.purple,
                ),
              );
            }),
            const Spacer(),
            SizedBox(
              width: 18,
              height: 18,
              child: Builder(builder: (context) {
                if (state is UserSuccess) {
                  return const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  );
                }
                return const CircularProgressIndicator(
                  color: Colors.purple,
                  strokeWidth: 2,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
