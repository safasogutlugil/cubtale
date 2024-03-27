class LoginState {
  final String username;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;

  LoginState({
    this.username = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
    this.isLoggedIn = false
  });

  LoginState copyWith({
    String? username,
    String? password,
    bool? isLoading,
    String? errorMessage,
    bool? isLoggedIn
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}