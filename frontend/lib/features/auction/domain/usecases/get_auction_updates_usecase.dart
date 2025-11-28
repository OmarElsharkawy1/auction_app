import '../entities/auction_item.dart';
import '../repositories/i_auction_repository.dart';

class GetAuctionUpdatesUseCase {
  final IAuctionRepository repository;

  GetAuctionUpdatesUseCase(this.repository);

  Stream<AuctionItem> call() {
    return repository.auctionUpdates;
  }
}
