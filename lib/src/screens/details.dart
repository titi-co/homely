import 'package:flutter/material.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/screens/home.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/utils/image.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

class Details extends StatefulWidget {
  const Details({super.key, this.property});

  final Property? property;

  static const routeName = "/details";

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                context,
              ),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: FlexibleHeaderDelegate(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).colorScheme.surfaceVariant,
                        ),
                        alignment: Alignment.center,
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: ThemeVariables.header,
                          ),
                        ),
                      ),
                    ),
                  ),
                  collapsedElevation: 1,
                  statusBarHeight: MediaQuery.of(context).padding.top,
                  expandedHeight: MediaQuery.of(context).size.height / 3,
                  background: MutableBackground(
                    expandedWidget: widget.property!.image == "" ||
                            widget.property!.image == null
                        ? const MissingImage()
                        : ImageUtils().imageFromBase64String(
                            base64String: widget.property!.image),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ThemeVariables.md,
                  vertical:
                      MediaQuery.of(context).padding.top + ThemeVariables.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.property!.name ?? "Title...",
                    style: ThemeVariables.sectionHeader,
                  ),
                  Text(
                    widget.property!.description ?? "Description...",
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
                    widget.property!.street ?? "Street...",
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
                    widget.property!.district ?? "District...",
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
                    widget.property!.city ?? "City...",
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
                    widget.property!.state ?? "State...",
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
