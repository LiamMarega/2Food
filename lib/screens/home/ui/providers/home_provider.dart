import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapfood/common/models/events.dart';
import 'package:snapfood/common/models/generated_classes.dart';
import 'package:snapfood/common/models/menu_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_provider.freezed.dart';
part 'home_provider.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    List<Restaurants>? restaurants,
    List<MenuItem>? promotions,
    List<Event>? events,
    @Default(false) bool isLoading,
  }) = _HomeState;
}

@Riverpod(keepAlive: true)
class Home extends _$Home {
  @override
  HomeState build() {
    _fetchRestaurants();
    _fetchPromotions();
    _fetchEvents();
    return const HomeState(isLoading: true);
  }

  SupabaseClient get supabase => Supabase.instance.client;

  Future<void> _fetchRestaurants() async {
    try {
      final data = await supabase
          .from('restaurants')
          .select()
          .eq('recommended', true)
          .withConverter(Restaurants.converter);

      state = state.copyWith(
        restaurants: data,
        isLoading: false,
      );
    } catch (e) {
      log('Error fetching restaurants: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _fetchPromotions() async {
    try {
      final data = await supabase
          .from('menu_items')
          .select('*, promotions(*)')
          .not('promotions', 'is', 'null')
          .withConverter(
            (promo) => (promo as List<dynamic>)
                .map((p) => MenuItem.fromJson(p as Map<String, dynamic>))
                .toList(),
          );

      state = state.copyWith(
        promotions: data,
        isLoading: false,
      );
    } catch (e, track) {
      log('Error fetching promotions: $e $track');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _fetchEvents() async {
    try {
      // Get current date to filter events that haven't expired
      final now = DateTime.now().toUtc().toIso8601String();

      // First fetch the raw data to inspect
      final rawData = await supabase
          .from('events')
          .select()
          .eq('active', true)
          .gte('date', now)
          .order('date', ascending: true);

      log('Raw events data: ${rawData.toString().substring(0, rawData.toString().length > 500 ? 500 : rawData.toString().length)}...');

      // Now convert with our safer converter
      final data = Event.converter(rawData);

      log('Events fetched successfully: ${data.length}');

      state = state.copyWith(
        events: data,
        isLoading: false,
      );
    } catch (e, stack) {
      log('Error fetching events: $e');
      log('Stack trace: $stack');
      state = state.copyWith(isLoading: false);
    }
  }
}
