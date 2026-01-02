import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;

  const SplashLogo({
    super.key,
    required this.scaleAnimation,
    required this.opacityAnimation,
  });

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00E676);
    return Transform.scale(
      scale: scaleAnimation.value,
      child: Opacity(
        opacity: opacityAnimation.value,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.rice_bowl, size: 64, color: primaryGreen),
        ),
      ),
    );
  }
}
