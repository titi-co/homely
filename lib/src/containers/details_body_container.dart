import 'package:flutter/material.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/screens/addVehicle.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/utils/sqlite.dart';
import 'package:sqflite/sqflite.dart';

class PropertyDetailsBody extends StatefulWidget {
  const PropertyDetailsBody({
    super.key,
    required this.property,
  });

  final Property? property;

  @override
  State<PropertyDetailsBody> createState() => _PropertyDetailsBodyState();
}

class _PropertyDetailsBodyState extends State<PropertyDetailsBody> {
  List? vehicles;
  init() async {
    Database db = await SQLiteUtils().db();

    vehicles = await db.query("vehicles",
        where: "propertyId = ?", whereArgs: [widget.property!.id]);
    setState(() {});
    print("vehicles: $vehicles");
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Widget getVehicleWidgets() {
    return Column(
        children: vehicles!
            .map(
              (item) => Container(
                margin: EdgeInsets.only(bottom: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ]),
                child: Row(
                  children: [
                    const Icon(Icons.car_rental),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['model'],
                          style: ThemeVariables.bodyRegular,
                        ),
                        Text(
                          item['color'],
                          style: ThemeVariables.bodyRegular,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ThemeVariables.md,
              vertical: MediaQuery.of(context).padding.top + ThemeVariables.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.property!.name,
                style: ThemeVariables.sectionHeader,
              ),
              Text(
                widget.property!.description,
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
                widget.property!.street,
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
                widget.property!.district,
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
                widget.property!.city,
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
                widget.property!.state,
                style: ThemeVariables.bodyRegular,
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddVehicle(
                        property: widget.property,
                        loadCallback: init,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ]),
                  child: Row(
                    children: [
                      const Icon(Icons.add),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Add Vehicle",
                        style: ThemeVariables.bodyRegular,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              getVehicleWidgets()
            ],
          ),
        ),
      ),
    );
  }
}
