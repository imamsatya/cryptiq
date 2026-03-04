import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import '../../core/theme/app_theme.dart';

/// A visual statistics card that can be captured as an image and shared.
class StatsCard extends StatelessWidget {
  final int completed;
  final int totalStars;
  final int maxStars;
  final int avgTime;
  final int totalHints;
  final int currentStreak;
  final GlobalKey repaintKey;

  const StatsCard({
    super.key,
    required this.completed,
    required this.totalStars,
    required this.maxStars,
    required this.avgTime,
    required this.totalHints,
    required this.currentStreak,
    required this.repaintKey,
  });

  /// Capture this widget as PNG and share
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
      final file = File('${dir.path}/cryptiq_stats.png');
      await file.writeAsBytes(pngBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'image/png')],
          text: '🧩 My CryptiQ Stats — Decode the Logic',
        ),
      );
    } catch (_) {}
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
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'My Stats',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary.withValues(alpha: 0.6),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),

            // Stats grid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _stat('$completed', 'Solved', Icons.check_circle_outline_rounded),
                _stat('$totalStars/$maxStars', 'Stars', Icons.star_rounded),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _stat(_formatTime(avgTime), 'Avg Time', Icons.timer_outlined),
                _stat('$totalHints', 'Hints', Icons.lightbulb_outline),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _stat('$currentStreak 🔥', 'Streak', Icons.local_fire_department_rounded),
              ],
            ),

            const SizedBox(height: 12),
            Text(
              'Decode the Logic',
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.textSecondary.withValues(alpha: 0.4),
                letterSpacing: 2,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String value, String label, IconData icon) {
    return SizedBox(
      width: 130,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 16),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            Text(label,
                style: TextStyle(
                    fontSize: 9,
                    color: AppTheme.textSecondary.withValues(alpha: 0.6))),
          ],
        ),
      ),
    );
  }
}
