# Proviyaa POS

Separate Restaurant POS product for the Proviyaa ecosystem. It consumes the OS-owned central Supabase PostgreSQL system and does not create a second cloud database.

Read `docs/PREFLIGHT.txt`, `docs/SOURCE-MANIFEST.txt`, `docs/PRD-DAY-03-RESTAURANT-POS.txt`, and `docs/DECISIONS-AND-QUESTIONS.txt` first.

Architecture: Flutter presentation -> commands/domain rules -> device-local SQLite and durable pending intent -> one replaceable sync adapter -> authorized domain APIs -> central PostgreSQL.

Local credentials: copy `.env.local.example` to `.env.local`, fill only local-safe values, and run `./tool/run_local.sh`. The launcher passes values as Flutter `--dart-define` flags and refuses unknown keys. Never add a Supabase service-role key or database password to the app. Figma remains the UI authority; no replacement design system is being introduced until the approved node metadata is available.
