import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/giveaway.dart';
import '../services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final giveawaysFutureProvider = FutureProvider<List<Giveaway>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.fetchGiveaways();
});

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void updateQuery(String query) => state = query;
  void clear() => state = '';
}

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(() {
  return SearchQueryNotifier();
});

class PlatformFilterNotifier extends Notifier<String> {
  @override
  String build() => 'All';

  void setPlatform(String platform) => state = platform;
}

final selectedPlatformFilterProvider =
    NotifierProvider<PlatformFilterNotifier, String>(() {
  return PlatformFilterNotifier();
});

final filteredGiveawaysProvider = Provider<AsyncValue<List<Giveaway>>>((ref) {
  final giveawaysAsync = ref.watch(giveawaysFutureProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final platformFilter = ref.watch(selectedPlatformFilterProvider);

  return giveawaysAsync.whenData((giveaways) {
    return giveaways.where((game) {
      final matchesQuery = query.isEmpty ||
          game.title.toLowerCase().contains(query) ||
          game.description.toLowerCase().contains(query) ||
          game.platforms.toLowerCase().contains(query);

      final matchesPlatform = platformFilter == 'All' ||
          game.platforms.toLowerCase().contains(platformFilter.toLowerCase());

      return matchesQuery && matchesPlatform;
    }).toList();
  });
});
