import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:schedule_qu/bloc/schedule/schedule_bloc.dart';
import 'package:schedule_qu/bloc/schedule/schedule_cubit.dart';
import 'package:schedule_qu/bloc/splash/splash_bloc.dart';
import 'package:schedule_qu/data/repository/schedule_repository.dart';
import 'app_routes.dart';
import 'bloc/user/user_bloc.dart';
import 'data/repository/user_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = GetIt.I.get<UserRepository>();
    ScheduleRepository scheduleRepository = GetIt.I.get<ScheduleRepository>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashBloc(
            userRepository.getCollectionModel(),
          ),
        ),
        BlocProvider(
          create: (context) => UserBloc(userRepository),
        ),
        BlocProvider(
          create: (context) => ScheduleCubit(DateTime.now()),
        ),
        BlocProvider(
          create: (context) => ScheduleBloc(scheduleRepository),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser,
        routeInformationProvider: appRouter.routeInformationProvider,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
