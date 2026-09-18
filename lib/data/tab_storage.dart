import 'tab_storage_stub.dart' if (dart.library.html) 'tab_storage_web.dart'
    as impl;

String? getPersistedTab() => impl.getPersistedTab();
void persistTab(String moduleName) => impl.persistTab(moduleName);
