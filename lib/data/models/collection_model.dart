// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CollectionModel extends Equatable {
  final String collectionId;
  final String documentId;

  const CollectionModel({required this.collectionId, required this.documentId});

  @override
  List<Object> get props => [collectionId, documentId];

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      collectionId: json['collection_id'],
      documentId: json['document_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'collection_id': collectionId, 'document_id': documentId};
  }
}
