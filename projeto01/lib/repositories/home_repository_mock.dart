import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:projeto01/models/post_model.dart';
import 'package:projeto01/repositories/home_repository.dart';

class HomeRepositoryMock implements HomeRepository {
  @override
  Future<List<PostModel>> getList() async {
    var value = await rootBundle.loadString('assets/data.json');

    List list = jsonDecode(value);

    return list.map((e) => PostModel.fromJson(e)).toList();
  }
}
