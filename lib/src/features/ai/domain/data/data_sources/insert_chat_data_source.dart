abstract interface class InsertChatDataSource {
  Future<int> insert(Map<String, Object?> map);
}
