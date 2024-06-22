import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_qu/core/failure.dart';

import '../provider/local/user_local_provider.dart';
import '../provider/remote/user_remote_provider.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> checkUsername(String username);
  Future<Either<Failure, String>> registerUsername(String username);
}

class UserRepositoryImpl extends UserRepository {
  final UserLocalProvider localProvider;
  final UserRemoteProvider remoteProvider;

  UserRepositoryImpl({
    required this.localProvider,
    required this.remoteProvider,
  });

  @override
  Future<Either<Failure, String>> checkUsername(String username) async {
    try {
      DocumentSnapshot snapshot = await remoteProvider.checkUsername(username);
      if (snapshot.exists) {
        await localProvider.setUsername(snapshot.id);
        return Right(snapshot.id);
      } else {
        return Left(
          Failure(
            message:
                'Username Anda belum terdaftar. Apakah Anda ingin mendaftarkan dengan username ini?',
          ),
        );
      }
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> registerUsername(String username) async {
    try {
      await remoteProvider.registerUsername(username);
      await localProvider.setUsername(username);
      return const Right('Username berhasil didaftarkan.');
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
