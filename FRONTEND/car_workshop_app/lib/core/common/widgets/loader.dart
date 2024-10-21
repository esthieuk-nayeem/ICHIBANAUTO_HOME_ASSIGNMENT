import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final BuildContext context;
  const Loader({required this.context, super.key});

  @override
  Widget build(context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
