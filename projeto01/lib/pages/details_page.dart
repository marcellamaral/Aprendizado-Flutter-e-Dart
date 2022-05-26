import 'package:flutter/material.dart';
import 'package:projeto01/models/post_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostModel post = ModalRoute.of(context)!.settings.arguments as PostModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            Text(post.body),
            const SizedBox(height: 24),
            Text('Noticia: ${post.id}, Autor: ${post.userId}'),
          ],
        ),
      ),
    );
  }
}
