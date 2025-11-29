import 'package:frontend/features/auction/domain/entities/auction_item.dart';

/// Interface for the auction repository.
abstract class AuctionRepository {
  /// A stream of real-time auction updates.
  Stream<AuctionItem> get auctionUpdates;

  /// Connects to the auction with the given [token].
  void connect(String token);

  /// Disconnects from the auction.
  void disconnect();

  /// Places a bid of [amount] with the given [token].
  void placeBid(double amount, String token);
}
