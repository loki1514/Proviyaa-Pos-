# Proviyaa POS — Development Journal

## 2026-09-15 — Proviyaa POS: Backend pushed from auth through sync — payments, offline sign-in, and the PowerSync spike

**Closed a real gap under the already-built Payment screen (it wasn't actually saving anything), built the local-first staff sign-in and 24-hour offline authorization the source material specifically calls for, built the retry/idempotency logic a background sync will eventually run on, and did the real client-side half of the PowerSync compatibility spike — checking current documentation rather than assuming, since this ecosystem moves fast.**

- **Why:** The last entry left off with four screens working visually and functionally in isolation. What was still missing was the plumbing the source material treats as non-negotiable: payments are their own record, not a status flag; a cashier who signs in once should keep working for a day without the network; and nothing about "sync" existed yet beyond a table that filled up and never drained. All of this is backend work, not more screens, so it went first.

- **Structural decisions:**
  - Payment is its own database table, separate from order status — the source is explicit that order, kitchen, payment, and settlement must never be collapsed into one status field.
  - The sync worker is built against an interface (`CommandTransport`), not a real server, because no real authorized-command API exists yet — the source material itself calls those "proposals, not existing endpoints," and this project doesn't get to invent that API unilaterally; Proviyaa OS owns it.
  - The PowerSync spike produced a real, load-bearing finding: adopting PowerSync would **replace** the sync worker just built, not run alongside it — running both would be exactly the "second competing sync engine" the decisions record already rules out. That's now written down before anyone builds both and has to unwind it later.
  - The real Supabase sign-in code was written against the current SDK (checked directly, not assumed) and compiles, but was **not** tested against the live project — there's no way to inspect what staff/auth schema actually exists there, and no test account was created, because creating accounts or handling credentials isn't something this session does on the founder's behalf.

- **What works now, verified for real, not assumed:**
  - Completing a cash payment now genuinely writes a row to its own `payments` table — confirmed by reading the actual database file after clicking through the app, the same way every other piece of this rebuild has been checked.
  - A cashier who signs in gets a 24-hour offline grant cached on the device; a second startup can read that grant with zero network calls. An expired grant is kept, not deleted — matching the source's explicit "preserve data, deny new privileged work" rule for that case.
  - The sync worker correctly treats "accepted" and "duplicate" as the same success, treats "rejected" and "conflict" as needing review without blocking the rest of the queue, and treats a plain network failure as "retry later," not a business rejection — all backed by tests, not just written and hoped for.
  - The PowerSync client packages were actually added to the project and confirmed to compile cleanly alongside everything already built, and real current pricing was checked (free tier exists but deactivates after a week idle, unsuited to a start-and-stop evaluation).

- **Left undone, deliberately:**
  - No real backend exists for the sync worker to talk to yet — it has nothing to synchronize with until Phase B's actual API or a PowerSync instance exists.
  - The real Supabase sign-in path is unverified against the live project. Someone with an actual staff login needs to try it.
  - PowerSync itself is not connected to anything — that needs the founder to create a PowerSync account and run a couple of SQL statements in the Supabase project, neither of which this session can do.
  - No new screens were built this pass, on purpose — the Takeaway screen, the Dine-In board, and the persistent navigation chrome are all still exactly where the last entry left them.

- **Open questions for the founder:**
  - PowerSync go/no-go: given it would replace the sync worker just built (not add to it), does the founder want to proceed with a real PowerSync account/instance, or keep the hand-built sync worker and wait for Phase B's real API instead?
  - Someone needs to actually sign in through the real Supabase Auth code with a genuine staff account to confirm it works end to end — this session could write and compile it, but not test it live.

## 2026-09-15 — Proviyaa POS: Four real screens rebuilt and click-tested end to end

**Continued the screen-by-screen rebuild from the real reference: order-capture, Payment, and Kitchen Display are now done, on top of Tables from earlier today — each one actually clicked through in the running app, not just visually compared. Found and fixed five real bugs by doing that, one of which would have crashed the app on next launch.**

- **Why:** "Looks right in a screenshot" and "works when you actually use it" are different claims. Given how much this project has already suffered from work that looked plausible but wasn't grounded in the real thing, every screen in this pass was driven end to end in the actual running app — adding items, sending a KOT, paying, advancing a kitchen ticket — before being called done.

- **Structural decisions:**
  - Corrected the kitchen ticket's state names to match the architecture source's own vocabulary (`New → Preparing → Ready → Completed`) instead of the informal names used when the domain was first sketched.
  - Payment only lets **Cash** actually complete a transaction. Card, UPI and Split Pay are shown (matching the real screens) but refuse with an explanation, because the source material is explicit that an unverified tap must never be treated as a confirmed digital payment.
  - Where the real screens show figures this app has no real logic for yet — service charge, a discount coupon, a tip, a live kitchen checklist with a progress bar — those are left out rather than filled in with invented numbers. Same principle both times: don't fake data to make a screen look more finished than the app actually is.

- **What works now, verified by actually doing it in the app:**
  - Order capture: pick a table, add items, watch the cart total compute correctly, and save the order.
  - Payment: the bill recap and total carry over correctly, Amount Received defaults to the exact total, quick-amount chips work, change due computes correctly, and completing a cash payment works.
  - Kitchen Display: a sent order shows up as a ticket in the right column immediately, and clicking through New → Preparing → Ready → Served moves it column to column and finally off the board — all backed by the real local database, the same one a device restart wouldn't lose data from.

- **Five real bugs found and fixed by running the app, not by reading the code:**
  1. Every "open this table" tap silently did nothing — the code was asking the wrong part of the screen for permission to navigate.
  2. The payment screen's own layout didn't fit in the space given to it.
  3. A visual warning buried in the log about how a list item was painted, which the framework itself flags as a real defect, not cosmetic.
  4. The most consequential one: the cash amount box defaulted to a bill nearly **100 times too large** (₹52,500 instead of ₹525) — a classic "counted the wrong unit" mistake that a quick glance at the running screen caught immediately and code review alone likely would not have.
  5. The app **crashed on launch** the next time it was tested, because a ticket saved earlier today under the old status names couldn't be read back under the corrected ones. Fixed for now by clearing that local test data; the underlying lesson — that renaming something already written to the database needs an explicit migration, not just a code change — is exactly what D10's "explicit numbered migrations" rule is there to prevent, once this reaches real devices with real data on them.

- **Left undone:** Takeaway orders and the Dine-In status board — two more real screens — are not rebuilt yet. Neither is the persistent top navigation (logo, tab bar, search, notifications) that every real screen actually has; right now, moving between screens uses a stand-in floating button and back arrows instead. Hold Orders, All Orders, and everything beyond V1 Phase C (Delivery, Online aggregator inbox, Store Control) remain untouched.

- **Open questions for the founder:** None new — Q02 and D07 corrections from earlier today stand; this entry is progress against them, not a new decision point.

## 2026-09-15 — Proviyaa POS: Rebuilding the real screens 1:1, first one done and verified

**Threw out the placeholder screens built earlier today, read the real 36-screen design reference the owner supplied, re-read all three ecosystem source documents in full to ground the rebuild, and delivered the first screen (Tables) rebuilt exactly against the real design — visually checked against the reference, not just assumed correct.**

- **Why:** Earlier today, UI was built from the PRD alone using generic placeholder styling, since no confirmed screens existed yet. The owner then pointed out — correctly — that this wasn't acceptable: they need the real product screens, exactly, with no invented layout. They supplied 36 exported screens (light and dark pairs of 17 real VINII POS screens) as the authoritative reference.

- **Structural corrections, sourced from re-reading the three ecosystem documents in full:**
  - Product naming was wrong. The correct names, confirmed directly from the source text, are **Proviyaa / Proviyaa Global** (not "Proviyaa OS"), **VINII POS** with Restaurant/Store/Service as its three verticals (not "VINII Restaurant POS" as one name), **One Latur** as the actual deployed customer marketplace (**OneCity** is the generic pattern name, not a different product), and **OnLatur** as the single delivery product (not two separate "Fulfilment" and "Rider" products). The decision record has been corrected with the old names struck through, not silently replaced.
  - The kitchen ticket lifecycle was under-specified. The architecture source names it explicitly: **New → Accepted → Preparing → Ready → Picked Up → Completed** — more precise than the four-state version built earlier today, which will be corrected in the next pass.
  - Typography was quietly wrong in a way that would have broken at the worst time: the first fix used a Google-hosted font that tries to download itself at startup — which fails silently on a sandboxed, offline-first POS (confirmed by actually testing it: it errored trying to reach fonts.gstatic.com and fell back to the wrong font). The real fix uses the exact font files already sitting in the project's assets folder, bundled into the app itself, so typography works with the network fully off — consistent with the PRD's own requirement that this app must survive "internet disabled and restart tested."

- **What works now:** The exact brand green (`#76EC00`) was confirmed by sampling actual pixels from the reference images, not eyeballed — the same color the very first (mistaken) Figma pull had already recorded, so it's now doubly confirmed. The Tables screen is rebuilt to match the real design: the same stats line, the same zone filters, the same per-status card styling (occupied/available/reserved/cleaning, each with the right color and the right action button). It was screenshotted running in the real app and checked side-by-side against the reference image, not just assumed to match from reading the code.

- **Left undone:** Five more screens from the real reference — order-capture (POS), Payment, Kitchen Display (KOT), Takeaway, and the Dine-In status board — are not rebuilt yet. Neither is the app's top navigation chrome (logo, tab bar, search, notifications). There is still no reference screen for shift open/close (opening float, counted cash, variance); the owner has confirmed it should be built to match the same visual language as a best-effort, not claimed as a 1:1 match since nothing to match against exists.

- **Open questions for the founder:** None new this entry — Q02 (screen reference) and D07 (naming) are both corrected and recorded; work continues screen-by-screen from here.

## 2026-09-15 — Proviyaa POS: Local database is real now, and a Figma mix-up was caught before it cost build time

**Implemented the approved local database technology end-to-end, confirmed the Supabase staging project, and caught — before writing any UI — that the only Figma link on file points to a back-office admin screen, not a restaurant order-taking screen.**

- **Why:** The morning's V1 decisions said the local database must be Drift/SQLite with automatic first-launch creation and versioned migrations (D10) — that existed only as a schema sketch until now. Separately, the owner asked for UI work to proceed strictly from a specific Figma link "going forward, no going away from that." Before committing to that, the actual content behind that link needed checking — the earlier session's own notes had already hedged that the node was "provisional App Builder" material, which turned out to matter.

- **Structural decisions:** None reversed. This session executed decisions already on record (D10) rather than making new ones — Drift on SQLite via `drift_flutter`, the current official Flutter-native way to open a Drift database (replacing the now-defunct `sqlite3_flutter_libs` package, which was checked live on pub.dev and confirmed end-of-life before it went into the dependency list).

- **What works now:**
  - The local database is real: `lib/data/app_database.dart` defines the `orders`, `order_lines`, and `pending_upload_intents` tables in Drift, auto-creates `proviyaa_pos.sqlite` on first launch, and carries an explicit migration strategy that never drops data on upgrade.
  - `lib/data/drift_local_store.dart` is a working, disk-backed implementation of the same `PosLocalStore` interface the order service already used — a cash order saved twice (a retried/replayed submission) still produces exactly one order and one pending-upload intent.
  - Four new automated tests prove this rather than just claim it: the database file appears only after first open, a saved order survives being closed and reopened (simulating the app restarting mid-shift), and a replayed save doesn't duplicate anything. All 7 tests in the project (up from 3) pass, and `flutter analyze` is still clean.
  - The Supabase project already sitting in the local, git-ignored `.env.local` file is now confirmed as the approved staging project (closing part of Q04) — though who can access it, its backup policy, and its region label are still unconfirmed.
  - The Figma link the owner sent (node `275:304`) turned out to be a vendor back-office "App Builder" screen — categories, a theme-color picker, Publish/Draft buttons — not a cashier order-taking screen. This was checked twice: once against the previously captured design data, and once against an actual cached screenshot of the screen, which was sent to the owner directly so they could see exactly what's there.

- **Left undone:** No order-capture UI was written. Building screens against a design reference that turned out to be the wrong screen would have meant redoing that work, so it stopped at the verification step and came back to the owner instead. Wiring `DriftLocalStore` into a real running app (today it's proven by tests, not yet used by `main.dart`) is also still pending, since there's no UI yet for it to serve.

- **Open questions for the founder:**
  - Which Figma screens actually cover the restaurant order-taking flow (tables, menu, order lines, kitchen ticket, cash/shift close)? Node `275:304` is not that.
  - If no such Figma screens exist yet, should UI work proceed from the written PRD instead (using this app-builder screen only for shared visual tokens — colors, type, spacing), and get reconciled against real screens once they exist?
  - Should the vendor "App Builder" panel itself eventually be built as a feature of this same POS app, or does it belong to a different Proviyaa product entirely? (Its own captured content suggests it's OS/vendor-configuration territory, not restaurant-counter territory — matching the boundary this project already committed to.)

## 2026-09-15 — Proviyaa POS: Local foundation validated, source-grounded, and V1 scope locked

**Got the local app actually running and verified, read the full ecosystem documentation to ground the POS's scope, and locked ten V1 product decisions so feature work can resume on solid ground.**

- **Why:** Before this session there was no working development environment, no confirmed understanding of how the Restaurant POS fits into the wider Proviyaa OS / Commerce / OneCity / Fulfilment / Rider / Finance system, and no locked decisions on device, payments, offline behavior, sync approach, or database technology. Any feature work started before this risked being built on wrong assumptions or duplicating systems the wider OS already owns.

- **Structural decisions:**
  - Local database will be **Drift on top of SQLite** (not a raw sqlite3 binding, not MySQL), with explicit numbered migrations created automatically on first launch, and no automatic deletion of unsynced records. MySQL was explicitly considered and ruled out.
  - Sync direction is **PowerSync**, pending a Flutter compatibility/cost spike — not a hand-built custom sync engine, so the POS doesn't end up maintaining a second sync system alongside whatever the wider OS uses.
  - The Restaurant POS's boundary was written down explicitly: it does **not** own identity, entitlements, configuration, the shared customer/order/payment/settlement records, or inventory — it reads those from the OS/Commerce/Inventory systems and only owns the local operator experience (tables, order capture, kitchen tickets, cash evidence, shift and sync status). This is now on record in `docs/SOURCE-UNDERSTANDING.txt` so future features don't accidentally rebuild OS-owned systems.
  - First device target is **Windows**, one primary POS per location for V1 (multi-terminal/offline coordination deferred), a **cash-first pilot** with digital payments held as "pending verification" rather than confirmed-paid, and a Figma screen (App Builder, node `275:304`) was pulled in read-only as provisional visual reference only — explicitly not final design approval.

- **What works now:** The app builds, analyzes clean, and its test suite passes — order save with pending status and totals, idempotent replay of a save, and the local-demo shell rendering — on a real Flutter 3.47.4 / Dart 3.13.3 toolchain (re-verified independently this session, not just taken on faith). A developer can run `./tool/run_local.sh` in local-demo mode with no cloud credentials required. Ten V1 decisions (device, offline topology, payment posture, timing limits, sync direction, Supabase environment ownership, product naming, Figma status, finance posture, and database technology) are written down as the standing baseline in `docs/DECISIONS-AND-QUESTIONS.txt`, each paired with the follow-up question (Q01–Q05) that spells out exactly what evidence would close it.

- **Left undone:** Feature/UI work was deliberately paused this session to do source-reading and decision-locking first, at the owner's explicit request. Drift/SQLite is still only a table definition — no package, first-launch opener, or migration runner yet. No Supabase project is wired up for real sync or schema inspection. Finance/tax rules, the final approved Figma file/node set, exact hardware models, the Supabase staging project, and the PowerSync spike are all still open (Q01–Q05 in `docs/DECISIONS-AND-QUESTIONS.txt`). The project also still has no git repository, so none of this history is committed anywhere yet.

- **Open questions for the founder:**
  - `.env.local` on this machine already has a live-looking Supabase project URL and publishable key filled in, but the decision record still lists the Supabase staging project as unconfirmed (Q04). Is this the approved staging project? If yes, Q04 should be marked resolved; if not, it should be cleared out before anyone builds against it.
  - The preflight note claiming the three ecosystem source documents were fully re-read reports line counts that don't match the files actually on disk (one file off by roughly 2×), even though the files themselves are byte-identical to the originally checksummed copies. Worth a spot check of `docs/SOURCE-UNDERSTANDING.txt`'s citations before leaning on them as fully verified.
  - Q01–Q05 (finance/tax rules, final Figma file/node set, exact hardware, Supabase staging project details, PowerSync spike acceptance criteria) still need sign-off before those parts of the build can move forward.
  - No git repository exists yet for this project — worth setting up before more work accumulates uncommitted.
