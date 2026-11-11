import 'package:flutter/material.dart';

import '../widgets/post_container.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          children: [
            PostContainer(),

            const Divider(thickness: 0.5, color: Colors.black),
          ],
        );
      },
    );
  }
}
