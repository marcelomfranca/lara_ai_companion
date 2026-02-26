abstract interface class UpdateChatDataSource {
  Future<int> update(String uid, {required Map<String, Object?> map});
}
