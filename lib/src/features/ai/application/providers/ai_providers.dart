import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/application/controllers/lara_config_controller.dart';
import '../../../../core/core_app.dart';
import '../../../../core/domain/entities/lara_config.dart';

part 'ai_providers.g.dart';

@Riverpod(keepAlive: true)
GenerativeModel geminiModel(Ref ref) {
  final configState = ref.watch(laraConfigControllerProvider);
  final config = configState.value ?? LaraConfig.initial();

  return GenerativeModel(
    model: 'gemini-2.5-flash',
    apiKey: CoreApp.geminiApiKey,
    systemInstruction: Content.system(config.toSystemInstruction()),
  );
}
