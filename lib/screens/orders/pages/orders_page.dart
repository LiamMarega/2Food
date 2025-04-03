import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:snapfood/screens/orders/widget/order_tab_bar.dart';
import 'package:snapfood/screens/orders/widget/order_item_card.dart';
import 'package:snapfood/screens/orders/widget/order_model.dart';
import 'package:snapfood/screens/orders/providers/order_provider.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          // Tab bar
          OrderTabBar(controller: _tabController),
          // Tab content
          Expanded(
            child: OrderListView(tabController: _tabController),
          ),
        ],
      ),
    );
  }
}

class OrderListView extends ConsumerWidget {
  final TabController tabController;

  const OrderListView({
    required this.tabController,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get orders from provider
    final orderState = ref.watch(orderProvider);

    if (orderState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (orderState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading orders',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              orderState.error!,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(orderProvider.notifier).fetchOrders(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final orders = orderState.orders;

    return TabBarView(
      controller: tabController,
      children: [
        // Active orders
        OrderListTab(orders: orders['Active'] ?? []),
        // Completed orders
        OrderListTab(orders: orders['Completed'] ?? []),
        // Canceled orders
        OrderListTab(orders: orders['Canceled'] ?? []),
      ],
    );
  }
}

class OrderListTab extends StatelessWidget {
  final List<OrderItem> orders;

  const OrderListTab({
    required this.orders,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 60,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No orders found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: OrderItemCard(order: orders[index]),
        );
      },
    );
  }
}
