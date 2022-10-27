import 'package:flutter/material.dart';

class ProjectColor {
  final ButtonStyle elevated = ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 158, 145, 214),
      minimumSize: const Size(300, 50),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))));
}
