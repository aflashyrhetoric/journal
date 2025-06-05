import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal/auth/auth_store.dart';
import 'package:journal/journal_entries/journal_entry_card.dart';
import 'package:journal/notifier/journal_entry_notifier.dart';

// JournalIndex becomes ConsumerStatefulWidget so we can trigger fetchEntries on first load
class JournalIndex extends ConsumerStatefulWidget {
  const JournalIndex({super.key});

  @override
  ConsumerState<JournalIndex> createState() => _JournalIndexState();
}

class _JournalIndexState extends ConsumerState<JournalIndex> {
  @override
  void initState() {
    super.initState();
    // Fetch entries when the widget is first created
    Future.microtask(() async {
      await ref.read(journalEntryProvider.notifier).fetchEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the current list of journal entries
    final entries = ref.watch(journalEntryProvider);

    return CustomScrollView(
      slivers: [
        // Pull to refresh
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            await ref.read(journalEntryProvider.notifier).fetchEntries();
          },
        ),

        // Title at top (turn into a Sliver)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text(
              'Journal',
              style: CupertinoTheme.of(
                context,
              ).textTheme.navLargeTitleTextStyle,
            ),
          ),
        ),

        if (entries.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/illustrations/rock.png',
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    'What\'s on your mind?',
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Write your first journal entry below.',
                    style: TextStyle(fontSize: 16),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      authStore.logout();
                    },
                    child: Text("Logout"),
                  ),
                ],
              ),
            ),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final entry = entries[index];
              return JournalEntryCard(entry: entry);
            }, childCount: entries.length),
          ),
      ],
    );
  }
}
