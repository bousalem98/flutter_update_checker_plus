abstract class IStoreDataSource {
  Future<String> getStoreVersion({required bool forceNoCache});
  Future<bool> needUpdate({required bool forceNoCache, String? storeVersion});
  Future<bool> update();
  Future<Map<String, Object?>> getStoreAndLocalVersions({
    required bool forceNoCache,
  });
}
