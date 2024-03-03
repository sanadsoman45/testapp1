import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> initialize();
  Future<bool> checkConnection();
}

class NetworkInfoImpl implements NetworkInfo {
  bool hasConnection = false;

  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});

  StreamController<bool> _connectionStatusController = StreamController<bool>.broadcast();

  Stream<bool> get connectionChange => _connectionStatusController.stream;

  @override
  Future<bool> initialize() async {
    debugPrint("initialize");
    connectionChecker.onStatusChange.listen(_connectionChange);
    return true; // Or any other value you want to return after initialization
  }

  void dispose() {
    _connectionStatusController.close();
  }

  void _connectionChange(InternetConnectionStatus status) {
    bool isConnected = status == InternetConnectionStatus.connected;
    if (isConnected != hasConnection) {
      hasConnection = isConnected;
      _connectionStatusController.add(hasConnection); // Notify listeners about the connection status change
    }
  }

  // The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      debugPrint("inside success");
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      debugPrint("Yes");
      _connectionStatusController.add(hasConnection); // Notify listeners about the connection status change
    }

    return hasConnection;
  }
}
