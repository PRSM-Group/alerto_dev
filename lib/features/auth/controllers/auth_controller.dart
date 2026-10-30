import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/auth_service.dart';

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
      final authService = ref.read(authServiceProvider);
      await authService.signIn(email: email, password: password);
    });
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      await authService.signUp(email: email, password: password);
    });
  }
}
