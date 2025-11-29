import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/auction/data/models/auction_item_model.dart';
import 'package:frontend/features/auction/domain/entities/auction_item.dart';

/// Tests for [AuctionItemModel].
void main() {
  final tBidModel = BidModel(
    user: 'testuser',
    amount: 100.0,
    timestamp: DateTime.parse('2023-01-01T00:00:00.000Z'),
  );

  final tAuctionItemModel = AuctionItemModel(
    id: 1,
    title: 'Test Item',
    description: 'Test Description',
    imageUrl: 'http://example.com/image.png',
    currentPrice: 100.0,
    highestBidder: 'testuser',
    bids: [tBidModel],
  );

  test('should be a subclass of AuctionItem entity', () async {
    expect(tAuctionItemModel, isA<AuctionItem>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': 1,
        'title': 'Test Item',
        'description': 'Test Description',
        'imageUrl': 'http://example.com/image.png',
        'currentPrice': 100.0,
        'highestBidder': 'testuser',
        'bids': [
          {
            'user': 'testuser',
            'amount': 100.0,
            'timestamp': '2023-01-01T00:00:00.000Z',
          },
        ],
      };
      // act
      final result = AuctionItemModel.fromJson(jsonMap);
      // assert
      expect(result, tAuctionItemModel);
    });
  });
}
