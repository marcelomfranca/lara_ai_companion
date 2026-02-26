import '../../../features/ai/domain/enums/ai_response_length_enum.dart';

class LaraConfig {
  final double humorLevel; // 0.0 a 1.0
  final String language;
  final double personalityTone;
  final AiResponseLengthEnum responseLength;

  LaraConfig({
    required this.humorLevel,
    required this.language,
    required this.personalityTone,
    required this.responseLength,
  });

  factory LaraConfig.initial() => LaraConfig(
    humorLevel: 0.5,
    language: 'English',
    personalityTone: 0.5,
    responseLength: AiResponseLengthEnum.medium,
  );

  LaraConfig copyWith({
    double? humorLevel,
    String? language,
    double? personalityTone,
    AiResponseLengthEnum? responseLength,
  }) {
    return LaraConfig(
      humorLevel: humorLevel ?? this.humorLevel,
      language: language ?? this.language,
      personalityTone: personalityTone ?? this.personalityTone,
      responseLength: responseLength ?? this.responseLength,
    );
  }

  String _getHumorDescription() {
    if (humorLevel < 0.34) return 'Serious & Analytical';
    if (humorLevel < 0.67) return 'Balanced & Friendly';

    return 'Witty & Playful';
  }

  String _getToneDescription() {
    if (personalityTone < 0.34) return 'Formal & Professional';
    if (personalityTone < 0.67) return 'Casual & Approachable';

    return 'Bold & Enthusiastic';
  }

  String toSystemInstruction() {
    return 'Your name is LARA, a charismatic and warm AI assistant. '
        'Special Command: If the user sends "higrt", it is a trigger for you to provide a initial unique greeting based on constraints provided below. '
        'Strict Compliance: Every response MUST strictly follow the current constraints provided below'
        'Current Constraints: '
        'Tone: ${_getToneDescription()}. '
        'Humor Level: ${_getHumorDescription()}. '
        'Language: $language. '
        'Response length: ${responseLength.name}.';
  }
}
