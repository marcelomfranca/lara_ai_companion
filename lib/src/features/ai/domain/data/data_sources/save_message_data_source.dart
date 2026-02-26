abstract interface class SaveMessageDataSource {
  Future<int> save(Map<String, Object?> map);
}
