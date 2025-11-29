import 'package:equatable/equatable.dart';

/// Represents an item up for auction.
class AuctionItem extends Equatable {
  /// The unique identifier of the auction item.
  final int id;

  /// The title of the item.
  final String title;

  /// A detailed description of the item.
  final String description;

  /// The URL of the item's image.
  final String imageUrl;

  /// The current highest bid amount.
  final double currentPrice;

  /// The name of the user who placed the highest bid.
  final String? highestBidder;

  /// A list of all bids placed on this item.
  final List<Bid> bids;

  const AuctionItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.currentPrice,
    this.highestBidder,
    required this.bids,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imageUrl,
    currentPrice,
    highestBidder,
    bids,
  ];
}

/// Represents a bid placed on an auction item.
class Bid extends Equatable {
  /// The name of the user who placed the bid.
  final String user;

  /// The amount of the bid.
  final double amount;

  /// The date and time when the bid was placed.
  final DateTime timestamp;

  const Bid({
    required this.user,
    required this.amount,
    required this.timestamp,
  });

  @override
  List<Object> get props => [user, amount, timestamp];
}
