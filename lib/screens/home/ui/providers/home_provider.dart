import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapfood/models/generated_classes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_provider.freezed.dart';
part 'home_provider.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    List<Restaurants>? restaurants,
    @Default(false) bool isLoading,
  }) = _HomeState;
}

@Riverpod(keepAlive: true)
class Home extends _$Home {
  @override
  HomeState build() {
    _fetchRestaurants();
    return const HomeState(isLoading: true);
  }

  Future<void> _fetchRestaurants() async {
    try {
      final data = await Supabase.instance.client
          .from('restaurants')
          .select()
          .eq('recommended', true)
          .withConverter(Restaurants.converter);

      state = HomeState(
        restaurants: data,
      );
    } catch (e) {
      log('Error fetching restaurants: $e');
      state = const HomeState();
    }
  }
}
