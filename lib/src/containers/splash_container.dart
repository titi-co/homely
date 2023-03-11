import 'package:flutter/material.dart';
import 'package:homely/src/theme/constants.dart';

class SplashContainer extends StatelessWidget {
  const SplashContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ThemeVariables.redColor,
        child: Center(
            child: Text(
          "home.ly",
          style: ThemeVariables.sheetTitle.copyWith(
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
