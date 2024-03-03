class PasswordState {
  final String password;
  final String newPassword;
  final String renewPassword;
  final String errorMessage;
  final String pageName;

  const PasswordState(
      {this.password = "",
      this.newPassword = "",
      this.renewPassword = "",
      this.errorMessage = "",
      this.pageName = ""});

  PasswordState copyWith(
      {String? password,
      String? newPassword,
      String? renewPassword,
      String? pageName,
      String? errorMessage}) {
    return PasswordState(
        pageName: pageName ?? this.pageName,
        newPassword: newPassword ?? this.newPassword,
        password: password ?? this.password,
        errorMessage: errorMessage ?? this.errorMessage,
        renewPassword: renewPassword ?? this.renewPassword);
  }
}
