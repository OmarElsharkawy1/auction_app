import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/auction/domain/usecases/connect_auction_usecase.dart';
import 'package:frontend/features/auction/domain/usecases/disconnect_auction_usecase.dart';
import 'package:frontend/features/auction/domain/usecases/get_auction_updates_usecase.dart';
import 'package:frontend/features/auction/domain/usecases/place_bid_usecase.dart';

import 'auction_state.dart';

class AuctionCubit extends Cubit<AuctionState> {
  final ConnectAuctionUseCase connectAuctionUseCase;
  final DisconnectAuctionUseCase disconnectAuctionUseCase;
  final PlaceBidUseCase placeBidUseCase;
  final GetAuctionUpdatesUseCase getAuctionUpdatesUseCase;

  StreamSubscription? _auctionSubscription;

  AuctionCubit({
    required this.connectAuctionUseCase,
    required this.disconnectAuctionUseCase,
    required this.placeBidUseCase,
    required this.getAuctionUpdatesUseCase,
  }) : super(AuctionInitial());

  void connect(String token) {
    emit(AuctionLoading());
    try {
      connectAuctionUseCase(ConnectAuctionParams(token: token));

      _auctionSubscription?.cancel();
      _auctionSubscription = getAuctionUpdatesUseCase().listen(
        (item) {
          // Convert Entity to Map for State (or update State to use Entity)
          // For now, let's keep State using Map to minimize refactor,
          // BUT ideally State should use Entity.
          // Let's update State to use Entity in next step or map it here.
          // Mapping to Map for compatibility with existing UI code for now.
          final itemMap = {
            'id': item.id,
            'title': item.title,
            'description': item.description,
            'imageUrl': item.imageUrl,
            'currentPrice': item.currentPrice,
            'highestBidder': item.highestBidder,
            'bids': item.bids
                .map(
                  (b) => {
                    'user': b.user,
                    'amount': b.amount,
                    'timestamp': b.timestamp.toString(),
                  },
                )
                .toList(),
          };
          emit(AuctionLoaded(itemMap));
        },
        onError: (error) {
          emit(AuctionError('Connection error: $error'));
        },
      );
    } catch (e) {
      emit(AuctionError('Failed to connect: $e'));
    }
  }

  void disconnect() {
    _auctionSubscription?.cancel();
    disconnectAuctionUseCase(NoParams());
    emit(AuctionInitial());
  }

  void placeBid(double amount, String token) {
    placeBidUseCase(PlaceBidParams(amount: amount, token: token));
  }

  @override
  Future<void> close() {
    _auctionSubscription?.cancel();
    return super.close();
  }
}
