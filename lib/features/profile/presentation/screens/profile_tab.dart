import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/profile_info.dart';
import '../../widgets/profile_item.dart';
import '../../widgets/modals/account_management.dart';
import '../../widgets/modals/manage_safewords.dart';
import '../../widgets/modals/privacy_settings.dart';
import '../../widgets/modals/terms_conditions.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  bool _isEditing = false;

  final _usernameController = TextEditingController(text: '@username');
  final _fullNameController = TextEditingController(text: 'Juliana Jimeno');

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  void _showBottomModal(Widget sheetContent) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => sheetContent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ProfileInfoSection(
            isEditing: _isEditing,
            usernameController: _usernameController,
            fullNameController: _fullNameController,
            onEditPressed: () => setState(() => _isEditing = true),
            onCancelPressed: () => setState(() => _isEditing = false),
            onSavePressed: () => setState(() => _isEditing = false),
          ),
          const Divider(height: 40),
          ProfileMenuItem(
            title: 'Manage Safewords',
            onTap: () => _showBottomModal(const ManageSafewords()),
          ),
          ProfileMenuItem(
            title: 'Privacy Settings',
            onTap: () => _showBottomModal(const PrivacySettings()),
          ),
          ProfileMenuItem(
            title: 'Account Management',
            onTap: () => _showBottomModal(const AccountManagement()),
          ),
          ProfileMenuItem(
            title: 'Terms & Conditions',
            onTap: () => _showBottomModal(const TermsConditions()),
          ),
        ],
      ),
    );
  }
}
