import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_qu/bloc/user/user_bloc.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});
  final Debouncer _debouncer = Debouncer(
    delay: const Duration(seconds: 1),
  );

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = context.read<UserBloc>();
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat datang,',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const Text(
              'Silahkan masukkan username Anda.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Username',
                fillColor: Colors.white,
                focusColor: Colors.white,
                border: UnderlineInputBorder(),
                filled: true,
              ),
              onChanged: (value) {
                _debouncer.run(() {
                  userBloc.checkUsername(value);
                });
              },
            ),
            BlocBuilder<UserBloc, bool>(
              bloc: userBloc,
              builder: (context, state) {
                return Visibility.maintain(
                  visible: state,
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
                    child: const Row(
                      children: [
                        Text(
                          'Checking your username...',
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                            strokeWidth: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<UserBloc, bool>(
        builder: (context, state) {
          return FloatingActionButton.extended(
            enableFeedback: !state,
            onPressed: () {},
            label: const Row(
              children: [Text('Next'), Icon(Icons.chevron_right)],
            ),
          );
        },
      ),
    );
  }
}

class Debouncer {
  final Duration delay;
  VoidCallback? _callback;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(VoidCallback callback) {
    _callback = callback;
    _timer?.cancel();
    _timer = Timer(delay, () {
      _callback?.call();
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
