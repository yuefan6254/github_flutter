import 'dart:math';
import 'package:flutter/material.dart';
import 'package:github_flutter/widgets/particle/particle_model.dart';
import 'package:github_flutter/widgets/particle/particle_painter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class ParticleWidget extends StatefulWidget {
  final int numberOfParticles;
  ParticleWidget(this.numberOfParticles);

  @override
  _ParticleWidgetState createState() => _ParticleWidgetState();
}

class _ParticleWidgetState extends State<ParticleWidget> {
  final Random random = Random();
  final List<ParticleModel> particles = [];

  void initState() {
    super.initState();
    widget.numberOfParticles.times(() => particles.add(ParticleModel(random)));
  }

  Widget build(BuildContext context) {
    return LoopAnimation(
      tween: ConstantTween(1),
      builder: (context, child, value) {
        _simulateParticles();
        return CustomPaint(
          painter: ParticlePainter(particles),
        );
      },
    );
  }

  _simulateParticles() {
    particles
        .forEach((particle) => particle.checkIfParticleNeedsToBeRestarted());
  }
}
