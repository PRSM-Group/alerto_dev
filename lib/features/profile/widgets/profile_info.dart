import 'package:flutter/material.dart';

class ProfileInfoSection extends StatelessWidget {
  final bool isEditing;
  final TextEditingController usernameController;
  final TextEditingController fullNameController;
  final VoidCallback onEditPressed;
  final VoidCallback onCancelPressed;
  final VoidCallback onSavePressed;

  const ProfileInfoSection({
    super.key,
    required this.isEditing,
    required this.usernameController,
    required this.fullNameController,
    required this.onEditPressed,
    required this.onCancelPressed,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (!isEditing)
              ElevatedButton.icon(
                onPressed: onEditPressed,
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Edit Info'),
              )
            else
              Row(
                children: [
                  OutlinedButton(
                    onPressed: onCancelPressed,
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onSavePressed,
                    child: const Text('Save'),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: usernameController,
          enabled: isEditing,
          decoration: const InputDecoration(labelText: 'Username'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: fullNameController,
          enabled: isEditing,
          decoration: const InputDecoration(labelText: 'Full Name'),
        ),
      ],
    );
  }
}
