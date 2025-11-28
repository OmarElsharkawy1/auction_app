import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_cubit.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_state.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:intl/intl.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key});

  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  final _bidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Auction'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuctionCubit>().disconnect();
              context.read<AuthCubit>().logout();
            },
          ),
        ],
      ),
      body: BlocBuilder<AuctionCubit, AuctionState>(
        builder: (context, state) {
          if (state is AuctionLoading || state is AuctionInitial) {
            return Center(child: CircularProgressIndicator());
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
                            child: Icon(Icons.image, size: 50),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                              SizedBox(height: 8),
                              Text(item['description']),
                              SizedBox(height: 20),
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
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Recent Bids',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: bids.length,
                          itemBuilder: (ctx, i) {
                            final bid = bids[i];
                            return ListTile(
                              leading: Icon(Icons.gavel),
                              title: Text('${bid['user']}'),
                              trailing: Text(
                                currency.format(bid['amount']),
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _bidController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Your Bid',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            prefixText: '\$',
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          final amount = double.tryParse(_bidController.text);
                          if (amount != null) {
                            final authState = context.read<AuthCubit>().state;
                            if (authState is AuthAuthenticated) {
                              context.read<AuctionCubit>().placeBid(
                                amount,
                                authState.token,
                              );
                              _bidController.clear();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: Text('BID'),
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
