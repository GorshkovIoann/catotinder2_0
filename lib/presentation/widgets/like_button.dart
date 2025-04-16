import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LikeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.thumb_up, color: Colors.green),
      onPressed: onPressed,
    );
  }
}
