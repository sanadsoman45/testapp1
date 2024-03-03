import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/core/route_Constants.dart';
import 'package:test_app/features/login%20screen/auth_bloc.dart';
import 'package:test_app/features/login%20screen/auth_event.dart';
import 'package:test_app/features/login%20screen/auth_state.dart';
import 'package:test_app/injection.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => serviceLocator<AuthBloc>())
        ],
        child: Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {},
              buildWhen: (previousState, currentState) {
                // Define the condition for building the UI based on the state changes
                return currentState.supportState == "supported" &&
                    currentState.canCheckBiometrics;
              },
              builder: (context, state) {
                context.read<AuthBloc>().add(checkDeviceConfig());
                context.read<AuthBloc>().add(CheckBiometrics());
                return Column(
                  children: [
                    Visibility(
                      visible: context.read<AuthBloc>().state.supportState ==
                              "supported" &&
                          context.read<AuthBloc>().state.canCheckBiometrics,
                      replacement: Text("Authentciating"),
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              context.read<AuthBloc>().add(Authenticate());
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(context
                                        .read<AuthBloc>()
                                        .state
                                        .isAuthenticating
                                    ? 'Cancel'
                                    : 'Authenticate: biometrics only'),
                                const Icon(Icons.fingerprint),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .pushNamed(AppRouteConstants.changepass);
                        },
                        child: Text("Change Password")),
                    ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .pushNamed(AppRouteConstants.resetpass);
                        },
                        child: Text("Reset Password")),
                  ],
                );
              }),
        ));
  }
}
