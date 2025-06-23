import 'package:flutter/material.dart';

/// Responsive design utilities for Flutter applications
class ResponsiveHelper {
  /// Calculates responsive font size based on screen width
  static double getResponsiveFontSize(BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return mobile;    // Mobile breakpoint
    if (width < 900) return tablet;    // Tablet breakpoint
    return desktop;                    // Desktop
  }

  /// Checks if device is mobile (width < 600px)
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;

  /// Checks if device is tablet (600px <= width < 900px)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 900;
  }

  /// Checks if device is desktop (width >= 900px)
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 900;

  /// Returns responsive padding based on device type
  static EdgeInsets getResponsivePadding(BuildContext context, {
    double mobile = 20.0,
    double tablet = 40.0,
    double desktop = 60.0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: getResponsiveFontSize(
        context,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
      ),
    );
  }
}

/// Provides responsive dimensions for widgets
class ResponsiveDimensions {
  final BuildContext context;

  ResponsiveDimensions(this.context);

  // Font sizes
  double get defaultFontSize => ResponsiveHelper.getResponsiveFontSize(
    context,
    mobile: 16,
    tablet: 18,
    desktop: 20,
  );

  // Spacing
  double get defaultSpacing => ResponsiveHelper.getResponsiveFontSize(
    context,
    mobile: 16,
    tablet: 24,
    desktop: 32,
  );

  // Button dimensions
  double get buttonHeight => ResponsiveHelper.getResponsiveFontSize(
    context,
    mobile: 48,
    tablet: 56,
    desktop: 64,
  );

  // Icon sizes
  double get iconSize => ResponsiveHelper.getResponsiveFontSize(
    context,
    mobile: 20,
    tablet: 24,
    desktop: 28,
  );
}

/// Builds different layouts based on screen size
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) return desktop;
        if (constraints.maxWidth >= 600) return tablet;
        return mobile;
      },
    );
  }
}