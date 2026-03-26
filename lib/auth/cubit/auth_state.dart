part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final bool showPassword;
  final bool showConfirmPassword;
  final bool agreedToTerms;
  final AuthStatus status;
  final String? errorMessage;
  final String? userName;
  final String? userEmail;

  const AuthState({
    this.showPassword = false,
    this.showConfirmPassword = false,
    this.agreedToTerms = false,
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.userName,
    this.userEmail,
  });

  AuthState copyWith({
    bool? showPassword,
    bool? showConfirmPassword,
    bool? agreedToTerms,
    AuthStatus? status,
    String? errorMessage,
    String? userName,
    String? userEmail,
  }) {
    return AuthState(
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      agreedToTerms: agreedToTerms ?? this.agreedToTerms,
      status: status ?? this.status,
      errorMessage: errorMessage,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
    );
  }
}
