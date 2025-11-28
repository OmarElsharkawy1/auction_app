import '../../../../core/usecases/usecase.dart';
import '../repositories/i_auction_repository.dart';

class DisconnectAuctionUseCase implements UseCase<void, NoParams> {
  final IAuctionRepository repository;

  DisconnectAuctionUseCase(this.repository);

  @override
  Future<void> call(NoParams params) async {
    repository.disconnect();
  }
}
