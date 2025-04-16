import 'package:flutter/material.dart';

class DislikeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DislikeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.thumb_down, color: Colors.red),
      onPressed: onPressed,
    );
  }
}
