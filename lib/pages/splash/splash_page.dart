import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/splash/splash_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, String?>(
      bloc: context.read<SplashBloc>(),
      listener: (context, state) {
        context.replace(state == null ? '/user' : '/home');
      },
      child: Scaffold(
        backgroundColor: Colors.purple[400],
        body: const Center(
          child: Text(
            'ScheduleQu',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
