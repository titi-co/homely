import 'package:flutter/material.dart';
import 'package:homely/src/theme/constants.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  static const routeName = "/details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height / 3,
                floating: false,
                pinned: false,
                title: null,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        fit: BoxFit.cover,
                        "https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/home-improvement/wp-content/uploads/2022/07/download-23.jpg",
                      ),
                    ],
                  ),
                ))
          ];
        },
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: ThemeVariables.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Manitoba, Canadá",
                    style: ThemeVariables.sectionHeader,
                  ),
                  Text(
                    "Property with 4 bedrooms and 2 bathrooms. It has a swimming pool and vacant area for construction.",
                    style: ThemeVariables.bodyRegular,
                  ),
                  const SizedBox(
                    height: ThemeVariables.lg,
                  ),
                  Text(
                    "Address",
                    style: ThemeVariables.sectionHeader,
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  Text(
                    "Street",
                    style: ThemeVariables.bodyHeader,
                  ),
                  Text(
                    "Av. dos Andradas, 3000",
                    style: ThemeVariables.bodyRegular,
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  Text(
                    "District",
                    style: ThemeVariables.bodyHeader,
                  ),
                  Text(
                    "Santa Efigênia",
                    style: ThemeVariables.bodyRegular,
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  Text(
                    "City",
                    style: ThemeVariables.bodyHeader,
                  ),
                  Text(
                    "Belo Horizonte",
                    style: ThemeVariables.bodyRegular,
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  Text(
                    "State",
                    style: ThemeVariables.bodyHeader,
                  ),
                  Text(
                    "Minas Gerais",
                    style: ThemeVariables.bodyRegular,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
