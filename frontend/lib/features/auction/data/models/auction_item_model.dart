import 'package:frontend/features/auction/domain/entities/auction_item.dart';

class AuctionItemModel extends AuctionItem {
  const AuctionItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.currentPrice,
    super.highestBidder,
    required List<BidModel> super.bids,
  });

  factory AuctionItemModel.fromJson(Map<String, dynamic> json) {
    return AuctionItemModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      currentPrice: (json['currentPrice'] as num).toDouble(),
      highestBidder: json['highestBidder'],
      bids: (json['bids'] as List).map((e) => BidModel.fromJson(e)).toList(),
    );
  }
}

class BidModel extends Bid {
  const BidModel({
    required super.user,
    required super.amount,
    required super.timestamp,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      user: json['user'],
      amount: (json['amount'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
