import 'package:local_auth/local_auth.dart';

class AuthState {
  final bool canCheckBiometrics;
  final String supportState;
  final List<BiometricType> availableBiometrics;
  final String authorized;
  final bool isAuthenticating;

   AuthState({
    this.canCheckBiometrics = false,
    this.supportState = '',
    List<BiometricType>? availableBiometrics,
    this.authorized = "Not Authorized",
    this.isAuthenticating = false
  }) :  availableBiometrics = availableBiometrics ?? [];

  AuthState copyWith(
      {bool? canCheckBiometrics,
      String? supportState,
      bool? isAuthenticating,
      List<BiometricType>? availableBiometrics,
      String? authorized}) {
    return AuthState(
        supportState: supportState ?? this.supportState,
        isAuthenticating: isAuthenticating?? this.isAuthenticating,
        canCheckBiometrics: canCheckBiometrics ?? this.canCheckBiometrics,
        availableBiometrics: availableBiometrics ?? this.availableBiometrics,
        authorized: authorized ?? this.authorized);
  }
}


