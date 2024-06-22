import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_qu/pages/splash/splash_page.dart';
import 'package:schedule_qu/pages/widgets/dialog.dart';

import '../../bloc/user/user_bloc.dart';
import 'widget/loading_check_user.dart';
import 'widget/username_field.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

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
            UsernameField(callback: (value) {
              userBloc.add(CheckUserEvent(value));
            }),
            MultiBlocListener(
              listeners: [
                _listenFailCheckUser(userBloc),
                _listenSuccessRegisterUser(userBloc),
              ],
              child: BlocBuilder<UserBloc, UserState>(
                bloc: userBloc,
                builder: (context, state) {
                  return LoadingCheckUser(state: state);
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.topRight,
              child: BlocSelector<UserBloc, UserState, bool>(
                bloc: userBloc,
                selector: (state) {
                  return state is UserCheckSuccess ||
                      state is UserRegisterSuccess;
                },
                builder: (context, state) {
                  return Visibility(
                    visible: state,
                    child: ElevatedButton(
                      onPressed: () {
                        context.replace('/home');
                      },
                      child: const Text('Next'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  BlocListener _listenFailCheckUser(UserBloc bloc) {
    return BlocListener<UserBloc, UserState>(
      bloc: bloc,
      listener: (context, state) {
        showAlertDialog(
          context,
          title: 'Failed',
          message: state.message,
          titlePosButton: 'Ya, Daftar',
          onPositiveClick: () {
            bloc.add(RegisterUserEvent(state.data));
          },
        );
      },
      listenWhen: (previous, current) => current is UserError,
    );
  }

  BlocListener _listenSuccessRegisterUser(UserBloc bloc) {
    return BlocListener<UserBloc, UserState>(
      bloc: bloc,
      listener: (context, state) {
        showAlertDialog(
          context,
          title: 'Success',
          message: state.message,
          visibleNegativeButton: false,
          titlePosButton: 'Ok',
        );
      },
      listenWhen: (previous, current) => current is UserRegisterSuccess,
    );
  }
}
