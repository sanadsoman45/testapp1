import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoInternetScreen extends StatelessWidget{

  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(body: Center(child: Text("No Internet")),);
  }
}