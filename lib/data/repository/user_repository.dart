import 'package:schedule_qu/core/failure.dart';
import 'package:schedule_qu/data/models/collection_model.dart';
import '../provider/local/user_local_provider.dart';
import '../provider/remote/user_remote_provider.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> login(
    String username,
    String password,
  );
  Future<Either<Failure, String>> register(
    String username,
    String password,
  );
  CollectionModel? getCollectionModel();
}

class UserRepositoryImpl extends UserRepository {
  final UserLocalProvider localProvider;
  final UserRemoteProvider remoteProvider;

  UserRepositoryImpl({
    required this.localProvider,
    required this.remoteProvider,
  });

  @override
  CollectionModel? getCollectionModel() {
    return localProvider.getCollectionModel();
  }

  @override
  Future<Either<Failure, String>> loginOrRegister(
    String username,
    String password,
  ) async {
    late CollectionModel? collection;
    late String message;
    try {
      collection = await remoteProvider.login(username, password);
      if (collection != null) {
        message = 'Login berhasil';
      } else {
        collection = await remoteProvider.register(
          username,
          password,
        );
        message = 'Akun barhasil didaftarkan.';
      }
      localProvider.saveCollection(collection);
      return Right(message);
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> login(
    String username,
    String password,
  ) async {
    try {
      CollectionModel? collection =
          await remoteProvider.login(username, password);
      if (collection != null) {
        await localProvider.saveCollection(collection);
        return const Right('Login Berhasil');
      }
      return Left(
        Failure(
          message:
              'Akun tidak ditemukan, Apakah Anda ingin mendaftarkan akun ini?',
        ),
      );
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> register(
    String username,
    String password,
  ) async {
    try {
      CollectionModel collection =
          await remoteProvider.register(username, password);
      await localProvider.saveCollection(collection);
      return const Right('Akun Anda berhasil didaftarkan.');
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
