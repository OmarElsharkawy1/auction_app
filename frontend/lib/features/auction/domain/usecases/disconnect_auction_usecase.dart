import '../../../../core/usecases/usecase.dart';
import '../repositories/auction_repository.dart';

class DisconnectAuctionUseCase implements UseCase<void, NoParams> {
  final AuctionRepository repository;

  DisconnectAuctionUseCase(this.repository);

  @override
  Future<void> call(NoParams params) async {
    repository.disconnect();
  }
}
