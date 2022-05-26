import 'package:flutter/material.dart';

import 'package:projeto01/controllers/home_controller.dart';
import 'package:projeto01/controllers/login_controller.dart';
import 'package:projeto01/repositories/home_repository_imp.dart';
import 'package:projeto01/services/prefs_service.dart';

import '../models/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = HomeController(HomeRepositoryImp());

  @override
  void initState() {
    super.initState();
    _homeController.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home '),
        actions: [
          IconButton(
            onPressed: () {
              PrefsService.remove();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ValueListenableBuilder<List<PostModel>>(
          valueListenable: _homeController.posts,
          builder: (_, posts, __) {
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (_, indice) {
                  PostModel post = posts[indice];
                  return ListTile(
                    onTap: () => Navigator.pushNamed(context, '/details',
                        arguments: post),
                    leading: Text('${post.id}'),
                    trailing: const Icon(Icons.arrow_forward),
                    title: Text(post.title),
                    //subtitle: Text(post.body),
                  );
                });
          }),
    );
  }
}
