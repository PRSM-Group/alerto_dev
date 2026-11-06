import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportScreen extends ConsumerWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Report Screen',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.black,

                      onPressed: () {
                        // Handle settings button press
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.black,
                      onPressed: () {
                        // Handle info button press
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Latest'),

                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const Tab(text: 'My Posts'),
            ],
          ),
        ),
      ),
    );
  }
}
