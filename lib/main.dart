import 'package:flutter/material.dart';
import 'package:test_app/core/routes_manager.dart';

import 'package:test_app/injection.dart' as packageDI;
import 'package:url_strategy/url_strategy.dart';

void main() async {
  await packageDI.init();
   setPathUrlStrategy();// to remove the # from route generated by gorouter.
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: MyAppRouter().router, //will implement and map the information obtained from info. parser.
  ));
}