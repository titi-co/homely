import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/theme/constants.dart';

class PropertiesEmptyContainer extends StatelessWidget {
  const PropertiesEmptyContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My places",
            style: ThemeVariables.sectionHeader,
          ),
          const SizedBox(
            height: ThemeVariables.md,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You don't have any places",
                  style: ThemeVariables.sectionHeader,
                ),
                const SizedBox(
                  height: ThemeVariables.md,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.secondary),
                    ),
                    onPressed: () {
                      BlocProvider.of<PropertiesBloc>(context)
                          .add(PropertiesFetch());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(ThemeVariables.md),
                      child: Text(
                        "Try again",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.brightness ==
                                  Brightness.dark
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
