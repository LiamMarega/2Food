import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapfood/common/models/menu_item.dart';
import 'package:snapfood/common/models/menu_type.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'products_provider.freezed.dart';
part 'products_provider.g.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState({
    List<MenuItem>? products,
    List<MenuType>? menuTypes,
    @Default(false) bool isLoading,
    String? error,
    String? currentMenuType,
  }) = _ProductsState;
}

@Riverpod(keepAlive: true)
class Products extends _$Products {
  @override
  ProductsState build() {
    fetchMenuTypes();
    return const ProductsState();
  }

  SupabaseClient get supabase => Supabase.instance.client;

  Future<void> fetchMenuTypes() async {
    // state = state.copyWith(isLoading: true, error: null);

    try {
      final data = await supabase
          .from('menu_types')
          .select()
          .eq('active', true)
          .order('type')
          .withConverter(MenuType.converter);

      state = state.copyWith(
        menuTypes: data,
        isLoading: false,
      );

      log('Fetched ${data.length} menu types');
    } catch (e, stack) {
      log('Error fetching menu types: $e');
      log('Stack trace: $stack');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load menu types: $e',
      );
    }
  }

  Future<void> fetchProductsByMenuType(String? menuTypeId) async {
    if (menuTypeId == null) {
      return;
    }

    // Don't reload if we're already showing products for this menu type
    if (state.currentMenuType == menuTypeId && state.products != null) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentMenuType: menuTypeId,
    );

    try {
      final data = await supabase
          .from('menu_items')
          .select('*, promotions(*)')
          .eq('menu_type', menuTypeId)
          .withConverter(
            (items) => (items as List<dynamic>)
                .map((item) => MenuItem.fromJson(item as Map<String, dynamic>))
                .toList(),
          );

      state = state.copyWith(
        products: data,
        isLoading: false,
      );

      log('Fetched ${data.length} products for menu type: $menuTypeId');
    } catch (e, stack) {
      log('Error fetching products: $e');
      log('Stack trace: $stack');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load products: $e',
      );
    }
  }

  Future<void> fetchAllProducts() async {
    state = state.copyWith(isLoading: true, error: null, currentMenuType: null);

    try {
      final data = await supabase
          .from('menu_items')
          .select('*, promotions(*)')
          .withConverter(
            (items) => (items as List<dynamic>)
                .map((item) => MenuItem.fromJson(item as Map<String, dynamic>))
                .toList(),
          );

      state = state.copyWith(
        products: data,
        isLoading: false,
      );

      log('Fetched ${data.length} products');
    } catch (e, stack) {
      log('Error fetching all products: $e');
      log('Stack trace: $stack');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load products: $e',
      );
    }
  }
}
