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

final filteredGiveawaysProvider = Provider<AsyncValue<List<Giveaway>>>((ref) {
  final giveawaysAsync = ref.watch(giveawaysFutureProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  return giveawaysAsync.whenData((giveaways) {
    if (query.isEmpty) return giveaways;
    return giveaways.where((game) {
      return game.title.toLowerCase().contains(query) ||
          game.description.toLowerCase().contains(query) ||
          game.platforms.toLowerCase().contains(query);
    }).toList();
  });
});
