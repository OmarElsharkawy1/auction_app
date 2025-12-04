import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/auction_item.dart';

/// A widget that displays a list of bids.
///
/// This widget renders a scrollable list of [Bid] items, showing the user's initial,
/// name, timestamp, and bid amount.
class BidList extends StatelessWidget {
  /// The list of bids to display.
  final List<Bid> bids;

  const BidList({super.key, required this.bids});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency();

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final bid = bids[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
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
                  bid.user[0].toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                bid.user,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(DateFormat('hh:mm a').format(bid.timestamp)),
              trailing: Text(
                currency.format(bid.amount),
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
    );
  }
}
