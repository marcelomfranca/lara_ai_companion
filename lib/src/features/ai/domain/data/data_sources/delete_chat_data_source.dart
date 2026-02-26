abstract interface class DeleteChatDataSource {
  Future<void> delete(List<int> indexList, [bool? all = false]);
}
