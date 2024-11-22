import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:solar_system/solar_system_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final distortionShader = await ui.FragmentProgram.fromAsset('assets/shaders/distortion.frag');

  runApp(
    ShaderProvider(
      shader: ShaderCollection(
        distortion: distortionShader,
        earthShader: distortionShader,
      ),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: SolarSystemApp(),
      ),
    ),
  );
}

class ShaderProvider extends InheritedWidget {
  const ShaderProvider({
    super.key,
    required this.shader,
    required super.child,
  });

  final ShaderCollection shader;

  static ShaderCollection of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ShaderProvider>();
    return provider!.shader;
  }

  @override
  bool updateShouldNotify(covariant ShaderProvider oldWidget) {
    return oldWidget.shader != shader;
  }
}

class ShaderCollection {
  final ui.FragmentProgram distortion;
  final ui.FragmentProgram earthShader;

  ShaderCollection({
    required this.distortion,
    required this.earthShader,
  });
}
