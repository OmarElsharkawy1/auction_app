import 'package:frontend/features/auction/data/datasources/auction_remote_data_source.dart';
import 'package:frontend/features/auction/domain/entities/auction_item.dart';
import 'package:frontend/features/auction/domain/repositories/i_auction_repository.dart';

class AuctionRepositoryImpl implements IAuctionRepository {
  final AuctionRemoteDataSource remoteDataSource;

  AuctionRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<AuctionItem> get auctionUpdates => remoteDataSource.auctionUpdates;

  @override
  void connect(String token) {
    remoteDataSource.connect(token);
  }

  @override
  void disconnect() {
    remoteDataSource.disconnect();
  }

  @override
  void placeBid(double amount, String token) {
    remoteDataSource.placeBid(amount, token);
  }
}
