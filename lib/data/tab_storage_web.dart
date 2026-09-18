// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

String? getPersistedTab() {
  try {
    return html.window.localStorage['proviyaa_selected_module'];
  } catch (_) {
    return null;
  }
}

void persistTab(String moduleName) {
  try {
    html.window.localStorage['proviyaa_selected_module'] = moduleName;
  } catch (_) {}
}
