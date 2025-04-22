import 'package:go_router/go_router.dart';
import 'package:snapfood/common/models/generated_classes.dart';
import 'package:snapfood/screens/home/ui/pages/home_page.dart';
import 'package:snapfood/screens/home/ui/pages/products_full_view_page.dart';
import 'package:snapfood/screens/home/ui/pages/restaurant_detail.dart';

final List<RouteBase> homeRoutes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
    routes: [
      GoRoute(
        path: 'restaurant/:id',
        builder: (context, state) {
          final restaurant = state.extra! as Restaurants;
          return RestaurantDetail(restaurant: restaurant);
        },
      ),
    ],
  ),
  GoRoute(
    path: '/products',
    name: 'products',
    builder: (context, state) {
      final categoryTitle = state.uri.queryParameters['title'];
      final categoryType = state.uri.queryParameters['type'];

      return ProductsFullViewPage(
        categoryTitle: categoryTitle,
        categoryType: categoryType,
      );
    },
  ),
];
