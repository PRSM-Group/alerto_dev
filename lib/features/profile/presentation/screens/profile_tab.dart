import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  bool _isLoading = true; // Added loading state for fetching data

  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController(text: '••••••••');

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  // Fetch user data on load
  Future<void> _fetchUserProfile() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      final data = await supabase
          .from('User')
          .select()
          .eq('userID', user.id)
          .single();

      setState(() {
        _usernameController.text = data['username'] ?? '';
        _fullNameController.text = data['fullName'] ?? '';
        _emailController.text = user.email ?? data['email'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _isLoading = false;
      });
    } catch (error) {
      debugPrint('Error fetching profile: $error');
      setState(() => _isLoading = false);
    }
  }

  // Save changes to Supabase
  Future<void> _saveProfileChanges() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      await supabase
          .from('User')
          .update({
            'username': _usernameController.text,
            'fullName': _fullNameController.text,
            'phone': _phoneController.text,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('userID', user.id);

      setState(() => _isEditing = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    } catch (error) {
      debugPrint('Error updating profile: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $error')),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
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
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              top: 12.0,
              left: 16.0,
              bottom: 2.0,
              right: 16.0,
            ),
            child: const Text(
              'Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ProfileInfoSection(
                  isEditing: _isEditing,
                  usernameController: _usernameController,
                  fullNameController: _fullNameController,
                  emailController: _emailController,
                  phoneController: _phoneController,
                  passwordController: _passwordController,
                  onEditPressed: () => setState(() => _isEditing = true),
                  onCancelPressed: () => setState(() => _isEditing = false),
                  onSavePressed: _saveProfileChanges,
                ),
                const SizedBox(height: 32.0),
                const Divider(height: 20),
                const SizedBox(height: 12.0),
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
