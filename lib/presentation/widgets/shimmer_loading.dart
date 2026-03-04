import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_theme.dart';

/// Shimmer loading placeholder for puzzle content
class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.surfaceColor,
      highlightColor: AppTheme.surfaceLight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Puzzle lines placeholder
            _line(180),
            const SizedBox(height: 12),
            _line(140),
            const SizedBox(height: 6),
            Container(
              width: 160,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            const SizedBox(height: 6),
            _line(160),

            const SizedBox(height: 32),

            // Letter tiles placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  6,
                  (_) => Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(double width) {
    return Container(
      width: width,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
