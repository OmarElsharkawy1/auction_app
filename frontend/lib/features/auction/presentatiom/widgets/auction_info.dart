import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuctionInfo extends StatelessWidget {
  final Map<String, dynamic> item;

  const AuctionInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency();

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Price',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
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
                      Icon(Icons.circle, size: 8, color: Colors.red),
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
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text('Description', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(
              item['description'],
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Text('Recent Bids', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
