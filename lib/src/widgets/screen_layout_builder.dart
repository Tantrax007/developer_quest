import 'package:flutter/widgets.dart';

/// Create a mobile or tablet layout depending on the screen size.
class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext) buildMobile;
  final Widget Function(BuildContext) buildTablet;

  const ResponsiveLayoutBuilder(
      {required this.buildMobile, required this.buildTablet});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < 600
        ? buildMobile(context)
        : buildTablet(context);
  }
}
