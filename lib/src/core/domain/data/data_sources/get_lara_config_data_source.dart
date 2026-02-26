abstract interface class GetLaraConfigDataSource {
  Future<
    ({
      double? humorLevel,
      double? personalityTone,
      String? language,
      int? responseLength,
    })
  >
  get();
}
