import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/providers/providers.dart';

class AuthService {
  final SupabaseClient _supabase;

  AuthService(this._supabase);

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return AuthService(supabase);
});
