import 'package:equatable/equatable.dart';

class AuctionItem extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double currentPrice;
  final String? highestBidder;
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

class Bid extends Equatable {
  final String user;
  final double amount;
  final DateTime timestamp;

  const Bid({
    required this.user,
    required this.amount,
    required this.timestamp,
  });

  @override
  List<Object> get props => [user, amount, timestamp];
}
