import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'coming_soon_screen.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobilePortrait;
  final Widget mobileLandscape;
  final Widget tabletPortrait;
  final Widget tabletLandscape;
  final Widget desktopPortrait;
  final Widget desktopLandscape;
  final double mobileBreakpoint;
  final double tabletBreakpoint;
  final double desktopBreakpoint;

  const ResponsiveLayout({
    super.key,
    required this.mobilePortrait,
    this.mobileLandscape = const ComingSoonScreen(),
    this.tabletPortrait = const ComingSoonScreen(),
    this.tabletLandscape = const ComingSoonScreen(),
    this.desktopPortrait = const ComingSoonScreen(),
    this.desktopLandscape = const ComingSoonScreen(),
    this.mobileBreakpoint = 600,
    this.tabletBreakpoint = 1024,
    this.desktopBreakpoint = 1440, // Add a custom desktop breakpoint if needed
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil().screenWidth;

    return OrientationBuilder(
      builder: (context, orientation) {
        bool isPortrait = orientation == Orientation.portrait;

        if (screenWidth < mobileBreakpoint) {
          // Mobile layout
          return isPortrait ? mobilePortrait : mobileLandscape;
        } else if (screenWidth >= mobileBreakpoint &&
            screenWidth < tabletBreakpoint) {
          // Tablet layout
          return isPortrait ? tabletPortrait : tabletLandscape;
        } else if (screenWidth >= desktopBreakpoint) {
          // Desktop layout
          return isPortrait ? desktopPortrait : desktopLandscape;
        } else {
          // Return the scaffold for cases not covered above
          return const ComingSoonScreen();
        }
      },
    );
  }
}
