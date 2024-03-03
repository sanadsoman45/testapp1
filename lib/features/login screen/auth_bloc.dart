import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:test_app/features/login%20screen/auth_event.dart';
import 'package:test_app/features/login%20screen/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LocalAuthentication auth;

  AuthBloc({required this.auth}) : super(AuthState()) {
    on<checkDeviceConfig>((event, emit) async {
      final bool isSupported = await auth.isDeviceSupported();
      if (isSupported) {
        emit(state.copyWith(supportState: 'supported'));
      } else {
        emit(state.copyWith(supportState: 'not supported'));
      }
    });

    on<CheckBiometrics>((event, emit) async {
      try {
        final bool canCheckBiometrics = await auth.canCheckBiometrics;
        emit(state.copyWith(canCheckBiometrics: canCheckBiometrics));
      } on PlatformException catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(canCheckBiometrics: false));
      }
    });

    on<GetAvailabaleBiometrics>((event, emit) async {
      try {
        final List<BiometricType> availableBiometrics =
            await auth.getAvailableBiometrics();
        emit(state.copyWith(availableBiometrics: availableBiometrics));
      } on PlatformException catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(availableBiometrics: []));
      }
    });

    on<Authenticate>((event, emit) async {
      bool authenticated = false;
      emit(state.copyWith(isAuthenticating: true, authorized: "Authenticating"));
      try {
        authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          options: const AuthenticationOptions(
            stickyAuth: true,
          ),
        );
      } on PlatformException catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(isAuthenticating: false, authorized: 'Error - ${e.message}'));
        return;
      }
      emit(state.copyWith(
          isAuthenticating: false,
          authorized: authenticated ? "Authorized" : "Not Authorized"));
          debugPrint("authentictaed is:${authenticated}");
    });
  }
}
