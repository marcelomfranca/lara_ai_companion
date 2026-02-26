abstract interface class GetChatsDataSource {
  Future<List<Map<String, dynamic>>> getChats({int? start, int? limit});
}
