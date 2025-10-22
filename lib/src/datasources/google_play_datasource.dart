import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:in_app_update/in_app_update.dart';
import 'i_store_datasource.dart';

class GooglePlayDataSource implements IStoreDataSource {
  @override
  Future<String> getStoreVersion({required bool forceNoCache}) async {
    try {
      final info = await InAppUpdate.checkForUpdate();
      return '${info.availableVersionCode}';
    } on MissingPluginException catch (_) {
      debugPrint('[🔄 Update] Installed not from Google Play');
    } on Exception catch (e) {
      debugPrint('[🔄 Update: getStoreVersion] err: ${e.toString()}');
    }
    return '0.0.0';
  }

  @override
  Future<bool> needUpdate(
      {required bool forceNoCache, String? storeVersion}) async {
    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability != UpdateAvailability.updateAvailable) {
        return false;
      }
      if (!info.flexibleUpdateAllowed) return false;
      return info.updateAvailability == UpdateAvailability.updateAvailable;
    } on MissingPluginException catch (_) {
      debugPrint('[🔄 Update] Installed not from Google Play');
      return false;
    } on Exception catch (e) {
      debugPrint('[🔄 Update: needUpdate] err: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<Map<String, Object?>> getStoreAndLocalVersions(
      {required bool forceNoCache}) async {
    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability != UpdateAvailability.updateAvailable) {
        return {'update': false, 'version': null, 'current': null};
      }
      if (!info.flexibleUpdateAllowed) {
        return {'update': false, 'version': null, 'current': null};
      }

      return info.updateAvailability == UpdateAvailability.updateAvailable
          ? {'update': true, 'version': null, 'current': null}
          : {'update': false, 'version': null, 'current': null};
    } on MissingPluginException catch (_) {
      debugPrint('[🔄 Update] Installed not from Google Play');
      return {'update': false, 'version': null, 'current': null};
    } on Exception catch (e) {
      debugPrint('[🔄 Update: needUpdate] err: ${e.toString()}');
      return {'update': false, 'version': null, 'current': null};
    }
  }

  @override
  Future<bool> update() async {
    try {
      final appUpdateResult = await InAppUpdate.startFlexibleUpdate();
      //Perform flexible update
      if (appUpdateResult == AppUpdateResult.success) {
        //App Update successful
        await InAppUpdate.completeFlexibleUpdate();
        return true;
      }
      return false;
    } on MissingPluginException catch (_) {
      debugPrint('[🔄 Update: update] Installed not from Google Play');
      return false;
    } catch (e) {
      debugPrint('[🔄 Update: update] err: ${e.toString()}');
      return false;
    }
  }
}
