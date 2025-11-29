import 'package:frontend/features/auction/domain/entities/auction_item.dart';

abstract class AuctionRepository {
  Stream<AuctionItem> get auctionUpdates;
  void connect(String token);
  void disconnect();
  void placeBid(double amount, String token);
}
