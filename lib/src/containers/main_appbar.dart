import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/widgets/signout_button.dart';
import 'package:homely/src/widgets/toggle_mode.dart';

class MainAppBar extends StatelessWidget implements PreferredSize {
  const MainAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget get child => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: ThemeVariables.md,
      elevation: 0,
      title: Row(
        children: [
          SvgPicture.asset(
            "lib/src/assets/icons/icon-logo.svg",
            height: ThemeVariables.sheet,
            color: Theme.of(context).colorScheme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          const SizedBox(
            width: ThemeVariables.xs,
          ),
          Text(
            "home.ly",
            style: ThemeVariables.logo,
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: ThemeVariables.md),
          child: Row(
            children: const [
              ToggleMode(),
              SizedBox(
                width: ThemeVariables.sm,
              ),
              SignOut(),
            ],
          ),
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size(
          double.infinity,
          ThemeVariables.sm,
        ),
        child: Divider(
          thickness: 1,
        ),
      ),
    );
  }
}
