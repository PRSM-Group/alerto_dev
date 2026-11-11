import 'package:flutter/material.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color: Colors.grey[200],

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('@danaln'), Text('7h ago')],
            ),
            Text('This is a sample post content.'),
            Text('Lorem ipsum lorem ipsum lorem ipsum'),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, // Left and right padding
                    vertical: 5, // Top and bottom padding
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Text('Suspicious Peopleasdasdasdasdasdasdasd'),
                ),

                Text('27'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
