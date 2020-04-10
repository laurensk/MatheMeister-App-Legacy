import 'package:flutter/material.dart';

class DeviceSize {
  static smallDevice(BuildContext context) {
    return MediaQuery.of(context).size.width <= 400;
  }
}