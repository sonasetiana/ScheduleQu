import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_qu/app_routes.dart';
import 'package:schedule_qu/pages/widgets/dialog.dart';

import '../../bloc/user/user_bloc.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
              'Silahkan login atau register akun Anda.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: usernameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Username',
                fillColor: Colors.white,
                focusColor: Colors.white,
                border: UnderlineInputBorder(),
                filled: true,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Password',
                fillColor: Colors.white,
                focusColor: Colors.white,
                border: UnderlineInputBorder(),
                filled: true,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.topRight,
              child: MultiBlocListener(
                listeners: [
                  _listenErrorLogin(userBloc),
                  _listenSuccessLogin(userBloc),
                  _listenSuccessRegister(userBloc)
                ],
                child: BlocBuilder<UserBloc, UserState>(
                  bloc: userBloc,
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        String username = usernameController.text;
                        String password = passwordController.text;
                        userBloc.add(
                          UserLoginEvent(username, password),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[100],
                      ),
                      child: Builder(builder: (context) {
                        if (state is UserLoading) {
                          return const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        }
                        return const Text(
                          'LOGIN or REGISTER',
                          style: TextStyle(color: Colors.deepPurple),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BlocListener _listenErrorLogin(UserBloc bloc) {
    return BlocListener<UserBloc, UserState>(
      bloc: bloc,
      listener: (context, state) {
        showAlertDialog(
          context,
          title: 'Failed',
          message: state.message,
          titlePosButton: 'Ya, Daftar',
          onPositiveClick: () {
            String username = usernameController.text;
            String password = passwordController.text;
            bloc.add(
              UserRegisterEvent(
                username,
                password,
              ),
            );
          },
        );
      },
      listenWhen: (previous, current) => current is UserError,
    );
  }

  BlocListener _listenSuccessLogin(UserBloc bloc) {
    return BlocListener<UserBloc, UserState>(
      bloc: bloc,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(state.message),
          ),
        );
        context.replace('/home');
      },
      listenWhen: (previous, current) => current is UserLoginSuccess,
    );
  }

  BlocListener _listenSuccessRegister(UserBloc bloc) {
    return BlocListener<UserBloc, UserState>(
      bloc: bloc,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(state.message),
          ),
        );
        context.replace('/home');
      },
      listenWhen: (previous, current) => current is UserRegisterSuccess,
    );
  }
}
