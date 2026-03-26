import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  // ── UI toggles ──────────────────────────────────────────────
  void toggleShowPassword() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void toggleShowConfirmPassword() {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  void toggleAgreedToTerms() {
    emit(state.copyWith(agreedToTerms: !state.agreedToTerms));
  }

  // ── Auth actions ─────────────────────────────────────────────
  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Please fill in all fields',
      ));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    // Simulate network call
    await Future.delayed(const Duration(milliseconds: 800));

    emit(state.copyWith(
      status: AuthStatus.authenticated,
      userName: email.split('@').first,
      userEmail: email,
    ));
  }

  Future<void> register(String name, String email, String password) async {
    if (name.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Please fill in all fields',
      ));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    await Future.delayed(const Duration(milliseconds: 800));

    emit(state.copyWith(
      status: AuthStatus.authenticated,
      userName: name,
      userEmail: email,
    ));
  }

  void logout() {
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  void clearError() {
    emit(state.copyWith(status: AuthStatus.initial, errorMessage: null));
  }
}
