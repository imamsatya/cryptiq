import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Animated floating particle background for the home screen.
class ParticleBackground extends StatefulWidget {
  final Widget child;
  const ParticleBackground({super.key, required this.child});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    _particles = List.generate(25, (_) => _Particle());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _ParticlePainter(
                    particles: _particles,
                    progress: _controller.value,
                    color: AppTheme.primaryColor,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _Particle {
  final double x;
  final double y;
  final double speed;
  final double size;
  final double opacity;
  final double phase;

  _Particle()
      : x = Random().nextDouble(),
        y = Random().nextDouble(),
        speed = 0.2 + Random().nextDouble() * 0.6,
        size = 1.5 + Random().nextDouble() * 2.5,
        opacity = 0.05 + Random().nextDouble() * 0.12,
        phase = Random().nextDouble() * 2 * pi;
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Color color;

  _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = (progress * p.speed + p.phase) % 1.0;
      final px = p.x * size.width + sin(t * 2 * pi) * 20;
      final py = ((p.y + t * p.speed) % 1.0) * size.height;

      final paint = Paint()
        ..color = color.withValues(alpha: p.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(px, py), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) => true;
}
