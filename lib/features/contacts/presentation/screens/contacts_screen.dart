import 'package:flutter/material.dart';

// import 'package:alerto_dev/app/main_shell.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: const Center(child: Text('Placeholder contacts screen')),
    );
  }
}
