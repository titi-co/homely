import 'package:flutter/material.dart';
import 'package:homely/src/containers/details_body_container.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/widgets/property_item.dart';
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
                    expandedWidget: CachedImage(
                      image: widget.property!.image,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: PropertyDetailsBody(
          property: widget.property,
        ),
      ),
    );
  }
}
