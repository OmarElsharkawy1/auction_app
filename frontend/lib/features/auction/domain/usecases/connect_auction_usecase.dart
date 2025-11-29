import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/auction_repository.dart';

class ConnectAuctionUseCase implements UseCase<void, ConnectAuctionParams> {
  final AuctionRepository repository;

  ConnectAuctionUseCase(this.repository);

  @override
  Future<void> call(ConnectAuctionParams params) async {
    repository.connect(params.token);
  }
}

class ConnectAuctionParams extends Equatable {
  final String token;

  const ConnectAuctionParams({required this.token});

  @override
  List<Object> get props => [token];
}
