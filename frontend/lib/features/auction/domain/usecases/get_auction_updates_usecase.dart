import '../../../../core/usecases/usecase.dart';
import '../entities/auction_item.dart';
import '../repositories/auction_repository.dart';

/// Use case for getting real-time auction updates.
class GetAuctionUpdatesUseCase implements StreamUseCase<AuctionItem, NoParams> {
  final AuctionRepository repository;

  GetAuctionUpdatesUseCase(this.repository);

  @override
  Stream<AuctionItem> call(NoParams params) {
    return repository.auctionUpdates;
  }
}
