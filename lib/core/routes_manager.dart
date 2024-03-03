//configuring the gorouter maps.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/core/route_Constants.dart';
import 'package:test_app/features/login%20screen/auth_Screen.dart';
import 'package:test_app/features/passwordscreen/password_screen.dart';


class MyAppRouter {
  GoRouter router = GoRouter(
    routes: [
      //router array

      //defining go route path for home.
      GoRoute(
          name: AppRouteConstants.homeRouteName,
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(child: AuthScreen());
          }),
      GoRoute(
          path: '/changepass',
          name: AppRouteConstants.changepass,
          pageBuilder: (context, state) {
            return const MaterialPage(child: PasswordScreen(routeName: AppRouteConstants.changepass,));
          }),
      GoRoute(
          name: AppRouteConstants.resetpass,
          path: '/resetpass',
          pageBuilder: (context, state) {
            return const MaterialPage(child: PasswordScreen(routeName: AppRouteConstants.resetpass,));
          })
    ],
    // errorPageBuilder: (context, state) {
    //   return const MaterialPage(
    //       child:
    //           ErrorPage()); // will invoke the error page when a error page needs to shown.
    // },
  );
}