import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/theme_provider.dart';

/// 页面级背景组件，为二级/三级页面提供背景图片和模糊效果
/// 主页面由 MainScaffold 的 GlassScaffold 处理，不需要此组件
class AppBackground extends ConsumerWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appStyleProvider);
    final hasBg = settings.backgroundImagePath != null &&
        settings.backgroundImagePath!.isNotEmpty;

    if (!hasBg) return child;

    return Stack(
      children: [
        // 背景图层
        Positioned.fill(
          child: Image.file(
            File(settings.backgroundImagePath!),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          ),
        ),
        // 模糊层
        if (settings.blurIntensity > 0)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: settings.blurIntensity,
                sigmaY: settings.blurIntensity,
              ),
              child: Container(color: Colors.black.withAlpha(15)),
            ),
          ),
        // 内容层
        Positioned.fill(child: child),
      ],
    );
  }
}
