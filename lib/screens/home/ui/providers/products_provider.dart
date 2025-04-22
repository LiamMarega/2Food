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
    Map<String, List<MenuItem>>? menuTypeProducts,
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
    try {
      // First, get a list of menu_type_ids that have at least one menu item
      final menuTypeIdsWithItems = await supabase
          .from('menu_items')
          .select('menu_type')
          .not('menu_type', 'is', 'null')
          .withConverter(
            (data) => (data as List<dynamic>)
                .map((item) {
                  log('Menu item data: $item');
                  return item['menu_type'] as String;
                })
                .toSet() // Use Set to remove duplicates
                .toList(),
          );

      log('Menu type IDs with items: $menuTypeIdsWithItems');

      if (menuTypeIdsWithItems.isEmpty) {
        log('No menu types found with associated menu items');
        state = state.copyWith(
          menuTypes: [],
          isLoading: false,
        );
        return;
      }

      // Then get the menu types that match these IDs
      final data = await supabase
          .from('menu_types')
          .select()
          .eq('active', true)
          .inFilter('id', menuTypeIdsWithItems)
          .order('type')
          .withConverter(MenuType.converter);

      state = state.copyWith(
        menuTypes: data,
        isLoading: false,
      );

      log('Fetched ${data.length} menu types with at least one menu item');

      // Pre-fetch products for specific menu types for homepage
      await fetchProductsForFeaturedMenuTypes();
    } catch (e, stack) {
      log('Error fetching menu types: $e');
      log('Stack trace: $stack');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load menu types: $e',
      );
    }
  }

  Future<void> fetchProductsForFeaturedMenuTypes() async {
    try {
      final featuredTypes = state.menuTypes;
      if (featuredTypes == null || featuredTypes.isEmpty) {
        return;
      }

      // Try to find hamburger and pizza menu types
      final burgerType = featuredTypes
          .where((type) => type.type.toLowerCase().contains('hamburgues'))
          .firstOrNull;

      final pizzaType = featuredTypes
          .where((type) => type.type.toLowerCase().contains('pizza'))
          .firstOrNull;

      if (burgerType == null && pizzaType == null) {
        // If neither type is found, just use the first two menu types
        await _fetchProductsForMenuTypes(
          featuredTypes.take(2).map((e) => e.id).toList(),
        );
      } else {
        // Fetch products for the found menu types
        final typeIds = [
          if (burgerType != null) burgerType.id,
          if (pizzaType != null) pizzaType.id,
        ];
        await _fetchProductsForMenuTypes(typeIds);
      }
    } catch (e, stack) {
      log('Error fetching featured products: $e');
      log('Stack trace: $stack');
    }
  }

  Future<void> _fetchProductsForMenuTypes(List<String> menuTypeIds) async {
    if (menuTypeIds.isEmpty) return;

    final currentProducts = state.menuTypeProducts ?? {};
    final newProducts = Map<String, List<MenuItem>>.from(currentProducts);

    for (final typeId in menuTypeIds) {
      try {
        final data = await supabase
            .from('menu_items')
            .select('*, promotions(*)')
            .eq('menu_type', typeId)
            .limit(10)
            .withConverter(
              (items) => (items as List<dynamic>)
                  .map(
                      (item) => MenuItem.fromJson(item as Map<String, dynamic>))
                  .toList(),
            );

        newProducts[typeId] = data;
        log('Fetched ${data.length} products for menu type: $typeId');
      } catch (e) {
        log('Error fetching products for menu type $typeId: $e');
      }
    }

    state = state.copyWith(menuTypeProducts: newProducts);
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
