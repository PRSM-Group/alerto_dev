import 'package:flutter/material.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('@danaln', style: TextStyle(fontSize: 12.0)),
                Text('7h ago', style: TextStyle(fontSize: 12.0)),
              ],
            ),
            const SizedBox(height: 5.0),

            Text(
              'Mag-ingat sa weirdos sa Mercury malapit sa EDSA, lmao lmao mga manyakis.',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            ),
            const SizedBox(height: 20.0),
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
                  child: Text(
                    'Suspicious People',
                    style: TextStyle(fontSize: 12.0),
                  ),
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
