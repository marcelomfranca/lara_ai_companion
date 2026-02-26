abstract interface class GetMessagesDataSource {
  Future<List<Map<String, dynamic>>> getAll(
    String uid, {
    int? start,
    int? limit,
  });
}
