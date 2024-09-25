import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry margin;

  const NeuBox({super.key, required this.child, required this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            // darker shadow on bottom right
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(4, 4),
            ),

            // lighter shadow on top left
            BoxShadow(
              color: Colors.white,
              blurRadius: 15,
              offset: const Offset(-4, -4),
            ),
          ]),
      padding: EdgeInsets.all(12),
      child: child,
      margin: margin,
    );
  }
}
