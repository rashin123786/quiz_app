import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  DeviceType get deviceType {
    final w = screenWidth;
    if (w < Breakpoints.mobile) return DeviceType.mobile;
    if (w < Breakpoints.tablet) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;

  T responsive<T>({required T mobile, T? tablet, required T desktop}) {
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop;
    }
  }

  double rfs(double mobileSize) {
    switch (deviceType) {
      case DeviceType.mobile:
        return mobileSize;
      case DeviceType.tablet:
        return mobileSize * 1.1;
      case DeviceType.desktop:
        return mobileSize * 1.2;
    }
  }

  double get hPad => responsive(mobile: 16.0, tablet: 32.0, desktop: 0.0);

  double get contentMaxWidth =>
      responsive(mobile: double.infinity, tablet: 720.0, desktop: 860.0);
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return switch (context.deviceType) {
      DeviceType.mobile => mobile,
      DeviceType.tablet => tablet ?? mobile,
      DeviceType.desktop => desktop,
    };
  }
}

class ContentConstraint extends StatelessWidget {
  final Widget child;
  final double? maxWidth;

  const ContentConstraint({super.key, required this.child, this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? context.contentMaxWidth,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.hPad),
          child: child,
        ),
      ),
    );
  }
}
