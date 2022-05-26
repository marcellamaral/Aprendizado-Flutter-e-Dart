import 'package:flutter/cupertino.dart';
import 'package:projeto01/repositories/home_repository.dart';

import '../models/post_model.dart';

class HomeController {
  final HomeRepository _homeRepository;
  HomeController(this._homeRepository);

  ValueNotifier<List<PostModel>> posts = ValueNotifier<List<PostModel>>([]);

  fetch() async {
    posts.value = await _homeRepository.getList();
  }
}
