import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:modak/src/api/auth/auth.dart';
import 'package:modak/src/api/endpoint.dart';

import 'collection_dto.dart';

class CollectionAPI {
  AuthAPI auth;
  Endpoint endpoint;
  CollectionAPI(this.auth, this.endpoint);

  Future<List<String>> getCollectionsUUID(int offset, int limit) async {
    final collectionsUUID = await auth.get(
        "${endpoint.baseurl}/collection?offset=$offset&limit=$limit",
        CollectionsUUID.fromJson);
    return collectionsUUID.collections;
  }

  Future<Collection> getCollectionByUUID(String uuid) async {
    final collection = await auth.get(
        "${endpoint.baseurl}/collection/$uuid", Collection.fromJson);
    return collection;
  }

  Future<String> postCollection(String imagePath, Collection collection) async {
    var multipatFiles = <http.MultipartFile>[];
    final jsonData = json.encode(collection.toJson());
    multipatFiles.add(http.MultipartFile.fromString('info', jsonData));

    final imageFile = await http.MultipartFile.fromPath('image', imagePath);
    multipatFiles.add(imageFile);
    final uuid = await auth.multipart<String, dynamic>(
        "${endpoint.baseurl}/collection/",
        (json) => json?["uuid"] ?? "",
        multipatFiles);
    return uuid;
  }
}
