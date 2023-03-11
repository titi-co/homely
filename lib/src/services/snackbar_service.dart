import 'package:flutter/material.dart';

class SnackBarService {
  late GlobalKey<ScaffoldMessengerState> scaffoldKey;

  static SnackBarService instance = SnackBarService();

  SnackBarService() {
    scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      message, bg) {
    return scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: bg,
      ),
    );
  }
}
