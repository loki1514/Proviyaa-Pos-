import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:proviyaa_pos/config/app_config.dart';
import 'package:proviyaa_pos/data/app_database.dart';
import 'package:proviyaa_pos/main.dart';

void main() {
  testWidgets('renders the local-demo shell', (WidgetTester tester) async {
    // A real on-disk database (drift_flutter's driftDatabase) schedules a
    // background timer that outlives a pumped test frame, which the test
    // binding flags as a leak — use an in-memory one here instead.
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    await tester.pumpWidget(
      ProviyaaPosApp(
        database: db,
        config: const AppConfig(
          appEnv: 'local',
          dataMode: 'local_demo',
          supabaseUrl: '',
          supabasePublishableKey: '',
          apiBaseUrl: '',
          syncEnabled: false,
        ),
      ),
    );

    // The app now opens inside the persistent PosShell (sidebar + top
    // bar), defaulted to the Dine In board — rebuilt 1:1 from
    // v1/POS-DINE-IN-V3.png, the explicit source-of-truth reference for
    // the application shell (see docs/JOURNAL.md).
    expect(find.text('VINII POS'), findsOneWidget);
    expect(find.text('Dine In Orders'), findsOneWidget);
    expect(find.text('T1'), findsOneWidget);
    expect(find.text('Rahul Sharma'), findsOneWidget);
  });
}
