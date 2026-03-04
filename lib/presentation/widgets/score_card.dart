import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import '../../core/theme/app_theme.dart';

/// A visual score card that can be captured as an image and shared.
class ScoreCard extends StatelessWidget {
  final int levelNumber;
  final int timeSeconds;
  final int hintsUsed;
  final int stars;
  final GlobalKey repaintKey;

  const ScoreCard({
    super.key,
    required this.levelNumber,
    required this.timeSeconds,
    required this.hintsUsed,
    required this.stars,
    required this.repaintKey,
  });

  /// Capture this widget as PNG and share via share_plus
  static Future<void> captureAndShare(GlobalKey key) async {
    try {
      final boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      final pngBytes = byteData.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/cryptiq_score.png');
      await file.writeAsBytes(pngBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'image/png')],
          text: '🧩 CryptiQ — Decode the Logic',
        ),
      );
    } catch (_) {
      // Fallback: share text if image capture fails
    }
  }

  String _formatTime(int s) {
    final m = s ~/ 60;
    final sec = s % 60;
    return '${m.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: repaintKey,
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: AppTheme.backgroundGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppTheme.primaryColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.goldGradient.createShader(bounds),
              child: const Text(
                'CryptiQ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
            Text(
              'Decode the Logic',
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.textSecondary.withValues(alpha: 0.5),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),

            // Level badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3)),
              ),
              child: Text(
                'Level $levelNumber',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                final isEarned = i < stars;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    isEarned ? Icons.star_rounded : Icons.star_border_rounded,
                    size: i == 1 ? 48 : 36,
                    color: isEarned
                        ? AppTheme.primaryColor
                        : AppTheme.textMuted.withValues(alpha: 0.3),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),

            // Stats row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _stat(Icons.timer_outlined, _formatTime(timeSeconds), 'Time'),
                  Container(
                      width: 1,
                      height: 30,
                      color: Colors.white.withValues(alpha: 0.1)),
                  _stat(Icons.lightbulb_outline, '$hintsUsed', 'Hints'),
                  Container(
                      width: 1,
                      height: 30,
                      color: Colors.white.withValues(alpha: 0.1)),
                  _stat(Icons.star_rounded, '$stars/3', 'Stars'),
                ],
              ),
            ),

            const SizedBox(height: 12),
            Text(
              'Can you beat my score?',
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary.withValues(alpha: 0.5),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 18),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        Text(label,
            style: TextStyle(
                fontSize: 10,
                color: AppTheme.textSecondary.withValues(alpha: 0.6))),
      ],
    );
  }
}
