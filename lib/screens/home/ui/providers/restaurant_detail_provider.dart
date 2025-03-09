import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapfood/common/models/generated_classes.dart';
import 'package:snapfood/common/models/menu_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'restaurant_detail_provider.freezed.dart';
part 'restaurant_detail_provider.g.dart';

@freezed
class RestaurantDetailState with _$RestaurantDetailState {
  const factory RestaurantDetailState({
    List<Restaurants>? restaurants,
    List<MenuItem>? menuItems,
    String? restaurantId,
    @Default(false) bool isLoading,
  }) = _RestaurantDetailState;
}

@Riverpod(keepAlive: true)
class RestaurantDetail extends _$RestaurantDetail {
  @override
  Future<RestaurantDetailState> build({required String restaurantId}) async {
    return _fetchRestaurantDetails(restaurantId);
  }

  Future<RestaurantDetailState> _fetchRestaurantDetails(
    String restaurantId,
  ) async {
    final data = await Supabase.instance.client
        .from('restaurants')
        .select()
        .eq('id', restaurantId)
        .withConverter(Restaurants.converter);

    return RestaurantDetailState(
      restaurants: data,
      restaurantId: restaurantId,
    );
  }

  Future<void> fetchMenuItems(String restaurantId) async {
    state = const AsyncLoading();
    try {
      state = AsyncData(
        state.value!.copyWith(
            // menuItems: menuItems,
            ),
      );
    } catch (e) {
      log('Error fetching menu items: $e');
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> refreshRestaurantData() async {
    if (state.value?.restaurantId == null) return;

    state = const AsyncLoading();
    try {
      final newState =
          await _fetchRestaurantDetails(state.value!.restaurantId!);
      state = AsyncData(newState);
    } catch (e) {
      log('Error refreshing restaurant data: $e');
      state = AsyncError(e, StackTrace.current);
    }
  }
}
