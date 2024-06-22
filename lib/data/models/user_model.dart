// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String docId;
  final String username;
  final String password;
  final Timestamp createdAt;

  const UserModel({
    this.docId = '',
    required this.username,
    required this.password,
    required this.createdAt,
  });

  factory UserModel.fromCollection(
    QueryDocumentSnapshot data,
  ) {
    return UserModel(
        docId: data.id,
        username: data.get('username'),
        password: data.get('password'),
        createdAt: data.get('created_at'));
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'created_at': createdAt
    };
  }

  @override
  List<Object> get props => [docId, username, password, createdAt];
}
