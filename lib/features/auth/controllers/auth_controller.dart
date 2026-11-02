import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:developer' as developer;

import '../services/auth_service.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // initial state is null
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        await ref
            .read(authServiceProvider)
            .signIn(email: email, password: password);

        // Temporary Console Success Log
        developer.log(
          'LOGIN SUCCESS: User successfully signed in as $email',
          name: 'auth.success',
        );
      } on AuthException catch (e) {
        // Temporary Console Error Log for Supabase Auth exceptions (wrong password, user not found, etc.)
        developer.log(
          'LOGIN FAILED: ${e.message} (Status Code: ${e.statusCode})',
          name: 'auth.error',
          error: e,
        );
        // Re-throw so Riverpod's AsyncValue captures the error state for UI display
        rethrow;
      } catch (e, stackTrace) {
        // Catch-all for unexpected local/network errors
        developer.log(
          'LOGIN ERROR: An unexpected error occurred: $e',
          name: 'auth.error',
          error: e,
          stackTrace: stackTrace,
        );
        rethrow;
      }
    });
  }

  Future<void> signUp(
    String email,
    String password,
    String username,
    String fullName,
    String phone,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);

      await authService.signUp(
        email: email,
        password: password,
        username: username,
        fullName: fullName,
        phone: phone,
      );
    });
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      await authService.signOut();
    });
  }
}
