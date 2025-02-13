import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
    @Default(false) bool isLoading,
  }) = _HomeState;
}

@Riverpod(
  keepAlive: true,
)
class Home extends _$Home {
  @override
  HomeState build() {
    _fetchRestaurants();
    _fetchPromotions();
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
            (promo) => log(promo.toString()),
          );

      // log('Promotions: ${data.first.toJson()}');

      state = state.copyWith(
        // promotions: data,
        isLoading: false,
      );
    } catch (e) {
      log('Error fetching promotions: $e');
      state = state.copyWith(isLoading: false);
    }
  }
}
