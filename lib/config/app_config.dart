class AppConfig {
  const AppConfig(
      {required this.appEnv,
      required this.dataMode,
      required this.supabaseUrl,
      required this.supabasePublishableKey,
      required this.apiBaseUrl,
      required this.syncEnabled});
  final String appEnv,
      dataMode,
      supabaseUrl,
      supabasePublishableKey,
      apiBaseUrl;
  final bool syncEnabled;
  bool get isLocalDemo => dataMode == 'local_demo';
  factory AppConfig.fromDartDefines() => AppConfig(
      appEnv: const String.fromEnvironment('APP_ENV', defaultValue: 'local'),
      dataMode:
          const String.fromEnvironment('DATA_MODE', defaultValue: 'local_demo'),
      supabaseUrl: const String.fromEnvironment('SUPABASE_URL'),
      supabasePublishableKey:
          const String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY'),
      apiBaseUrl: const String.fromEnvironment('PROVIYAA_API_BASE_URL'),
      syncEnabled:
          const bool.fromEnvironment('SYNC_ENABLED', defaultValue: false));
}
