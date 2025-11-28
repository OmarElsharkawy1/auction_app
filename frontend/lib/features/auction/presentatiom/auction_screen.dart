import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_cubit.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_state.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AuctionScreen extends StatelessWidget {
  const AuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Auction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuctionCubit>().disconnect();
              context.read<AuthCubit>().logout();
              context.go('/');
            },
          ),
        ],
      ),
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                          item['imageUrl'],
                          height: 250,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(
                            height: 250,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image, size: 50),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(item['description']),
                              const SizedBox(height: 20),
                              Text(
                                'Current Price: ${currency.format(item['currentPrice'])}',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              if (item['highestBidder'] != null)
                                Text(
                                  'Highest Bidder: ${item['highestBidder']}',
                                ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Recent Bids',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bids.length,
                          itemBuilder: (ctx, i) {
                            final bid = bids[i];
                            return ListTile(
                              leading: const Icon(Icons.gavel),
                              title: Text('${bid['user']}'),
                              trailing: Text(
                                currency.format(bid['amount']),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                DateFormat(
                                  'dd-MM-yyyy hh:mm a',
                                ).format(DateTime.parse(bid['timestamp'])),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          // We use a key to force rebuild if we want to clear it,
                          // but simpler is to just let it be.
                          // If we want to clear it, we can use a key that changes on successful bid.
                          // For now, standard stateless input.
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Your Bid',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            prefixText: '\$',
                          ),
                          onChanged: (value) => context
                              .read<AuctionCubit>()
                              .bidAmountChanged(value),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          final authState = context.read<AuthCubit>().state;
                          if (authState is AuthAuthenticated) {
                            context.read<AuctionCubit>().placeBid(
                              authState.token,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('BID'),
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
