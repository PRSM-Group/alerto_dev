import 'package:flutter/material.dart';
import 'package:alerto_dev/theme/app_colors.dart';

class ProfileInfoSection extends StatelessWidget {
  final bool isEditing;
  final TextEditingController usernameController;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback onEditPressed;
  final VoidCallback onCancelPressed;
  final VoidCallback onSavePressed;

  const ProfileInfoSection({
    super.key,
    required this.isEditing,
    required this.usernameController,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
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
            if (!isEditing)
              ElevatedButton.icon(
                onPressed: onEditPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  backgroundColor: AppColors.background,
                  foregroundColor: Colors.black,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                icon: const Icon(Icons.edit, size: 14),
                label: const Text('Edit Info', style: TextStyle(fontSize: 12)),
              )
            else
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: onCancelPressed,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: AppColors.background,
                      foregroundColor: Colors.black,
                    ),
                    icon: const Icon(Icons.cancel_outlined, size: 14),
                    label: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: onSavePressed,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: const Icon(Icons.save_alt_outlined, size: 14),
                    label: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 24),

        _buildInfoRow(
          label: 'Username',
          controller: usernameController,
          isEditing: isEditing,
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          label: 'Full Name',
          controller: fullNameController,
          isEditing: isEditing,
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          label: 'Email Address',
          controller: emailController,
          isEditing: isEditing,
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          label: 'Phone Number',
          controller: phoneController,
          isEditing: isEditing,
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          label: 'Password',
          controller: passwordController,
          isEditing: isEditing,
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    bool obscureText = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 32),
        SizedBox(
          width: 200,
          child: TextField(
            controller: controller,
            enabled: isEditing,
            obscureText: obscureText,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 15, color: Colors.black54),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              border: isEditing ? const OutlineInputBorder() : InputBorder.none,
              enabledBorder: isEditing
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    )
                  : InputBorder.none,
              focusedBorder: isEditing
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    )
                  : InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
