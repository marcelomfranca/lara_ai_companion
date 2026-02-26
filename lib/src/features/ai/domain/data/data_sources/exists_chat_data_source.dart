abstract interface class ExistsChatDataSource {
  Future<bool> exists(String uid);
}
