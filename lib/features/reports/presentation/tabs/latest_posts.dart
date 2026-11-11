import 'package:flutter/material.dart';

import '../widgets/post_list.dart';

class LatestPostsTab extends StatelessWidget {
  const LatestPostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return PostList();
  }
}
