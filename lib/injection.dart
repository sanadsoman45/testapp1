import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:test_app/core/network_info.dart';
import 'package:test_app/core/routes_manager.dart';
import 'package:test_app/features/login%20screen/auth_bloc.dart';
import 'package:test_app/features/passwordscreen/passwordscreenbloc.dart';


///file for maintaining & declaring the dependency injections in the app.

final serviceLocator = GetIt.instance;

Future<void> init() async {

  //the below instances will be created only once and it will be when they are invoked for the first time.

  // go router delegate instance 
  // serviceLocator.registerLazySingleton<GoRouterDelegate>(() => MyAppRouter().router.routerDelegate);

  // //go routeinformationparser
  // serviceLocator.registerLazySingleton<GoRouteInformationParser>(() => MyAppRouter().router.routeInformationParser);
  // serviceLocator.registerLazySingleton<GoRouteInformationProvider>(() => MyAppRouter().router.routeInformationProvider);
  serviceLocator.registerLazySingleton<GoRouterDelegate>(() => MyAppRouter().router.routerDelegate);

  //go routeinformationparser
  serviceLocator.registerLazySingleton<GoRouteInformationParser>(() => MyAppRouter().router.routeInformationParser);
  serviceLocator.registerLazySingleton<GoRouteInformationProvider>(() => MyAppRouter().router.routeInformationProvider);

  serviceLocator.registerFactory<LocalAuthentication>(() => LocalAuthentication());

  serviceLocator.registerFactory<AuthBloc>(() =>AuthBloc(auth: serviceLocator<LocalAuthentication>()));// depenbdency injection of pagebloc.
  serviceLocator.registerFactory<PasswordBloc>(() => PasswordBloc());

  serviceLocator.registerLazySingleton<InternetConnectionChecker>(()=>InternetConnectionChecker());

  serviceLocator.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(connectionChecker: serviceLocator<InternetConnectionChecker>()));
}