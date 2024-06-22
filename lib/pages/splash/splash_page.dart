import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_qu/pages/home/home_page.dart';

import '../../bloc/splash/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, void>(
      listener: (context, state) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              const HomePage(), // Ganti dengan layar utama Anda
        ));
      },
      child: Scaffold(
        backgroundColor: Colors.purple[400],
        body: Center(
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