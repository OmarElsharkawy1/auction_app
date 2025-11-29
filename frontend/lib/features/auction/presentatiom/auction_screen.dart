import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_cubit.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_state.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key});

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  late ScrollController _scrollController;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    // Connect to auction when screen initializes
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      context.read<AuctionCubit>().connect(authState.token);
    }
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;

    final isCollapsed = _scrollController.offset > (250 - kToolbarHeight);
    if (isCollapsed != _isCollapsed) {
      setState(() {
        _isCollapsed = isCollapsed;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuctionCubit, AuctionState>(
        builder: (context, state) {
          if (state is AuctionLoading || state is AuctionInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AuctionError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is AuctionLoaded) {
            final item = state.item;
            final currency = NumberFormat.simpleCurrency();
            final bids = (item['bids'] as List).cast<Map<String, dynamic>>();

            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 300,
                        pinned: true,
                        iconTheme: IconThemeData(
                          color: _isCollapsed ? Colors.black : Colors.white,
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            item['title'],
                            style: TextStyle(
                              color: _isCollapsed ? Colors.black : Colors.white,
                              shadows: _isCollapsed
                                  ? null
                                  : const [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black45,
                                        offset: Offset(2.0, 2.0),
                                      ),
                                    ],
                            ),
                          ),
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                item['imageUrl'],
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image, size: 50),
                                ),
                              ),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black54,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(
                              Icons.logout,
                              color: _isCollapsed ? Colors.black : Colors.white,
                            ),
                            onPressed: () {
                              context.read<AuctionCubit>().disconnect();
                              context.read<AuthCubit>().logout();
                              context.go('/');
                            },
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Current Price',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Colors.grey[600]),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          'LIVE',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                currency.format(item['currentPrice']),
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                item['description'],
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 32),
                              Text(
                                'Recent Bids',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final bid = bids[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 8.0,
                            ),
                            child: Card(
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.1),
                                  child: Text(
                                    bid['user'][0].toUpperCase(),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  bid['user'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  DateFormat(
                                    'hh:mm a',
                                  ).format(DateTime.parse(bid['timestamp'])),
                                ),
                                trailing: Text(
                                  currency.format(bid['amount']),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }, childCount: bids.length),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 100),
                      ), // Space for bottom bar
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter amount',
                            prefixText: '\$ ',
                            prefixStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) => context
                              .read<AuctionCubit>()
                              .bidAmountChanged(value),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            final authState = context.read<AuthCubit>().state;
                            if (authState is AuthAuthenticated) {
                              context.read<AuctionCubit>().placeBid(
                                authState.token,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('Place Bid'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
