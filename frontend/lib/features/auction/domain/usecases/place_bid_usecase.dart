import 'package:equatable/equatable.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/auction/domain/repositories/auction_repository.dart';

class PlaceBidUseCase implements UseCase<void, PlaceBidParams> {
  final AuctionRepository repository;

  PlaceBidUseCase(this.repository);

  @override
  Future<void> call(PlaceBidParams params) async {
    repository.placeBid(params.amount, params.token);
  }
}

class PlaceBidParams extends Equatable {
  final double amount;
  final String token;

  const PlaceBidParams({required this.amount, required this.token});

  @override
  List<Object> get props => [amount, token];
}
