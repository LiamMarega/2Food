import 'package:flutter/material.dart';

double mediaWidth(BuildContext context, double factor) {
  return MediaQuery.of(context).size.width * factor;
}

double mediaHeight(BuildContext context, double factor) {
  return MediaQuery.of(context).size.height * factor;
}

Size mediaSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

EdgeInsets mediaPadding(BuildContext context) {
  return MediaQuery.of(context).padding;
}

double mediaDevicePixelRatio(BuildContext context) {
  return MediaQuery.of(context).devicePixelRatio;
}

Orientation mediaOrientation(BuildContext context) {
  return MediaQuery.of(context).orientation;
}

bool isLandscape(BuildContext context) {
  return mediaOrientation(context) == Orientation.landscape;
}

bool isPortrait(BuildContext context) {
  return mediaOrientation(context) == Orientation.portrait;
}

double screenWidth(BuildContext context) {
  return mediaWidth(context, 1);
}

double screenHeight(BuildContext context) {
  return mediaHeight(context, 1);
}

/// Returns true if the screen width is less than 600dp
bool isSmallScreen(BuildContext context) {
  return screenWidth(context) < 600;
}

/// Returns true if the screen width is between 600dp and 900dp
bool isMediumScreen(BuildContext context) {
  return screenWidth(context) >= 600 && screenWidth(context) < 900;
}

/// Returns true if the screen width is greater than 900dp
bool isLargeScreen(BuildContext context) {
  return screenWidth(context) >= 900;
}

/// Safely access MediaQuery data
T withMediaQuery<T>(
    BuildContext context, T Function(MediaQueryData data) callback,) {
  return callback(MediaQuery.of(context));
}
