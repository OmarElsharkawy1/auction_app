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
      _auctionSubscription = getAuctionUpdatesUseCase(NoParams()).listen(
        (item) {
          double currentBidAmount = 0.0;
          if (state is AuctionLoaded) {
            currentBidAmount = (state as AuctionLoaded).bidAmount;
          }

          emit(AuctionLoaded(item, bidAmount: currentBidAmount));
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

  void bidAmountChanged(String amountStr) {
    if (state is AuctionLoaded) {
      final amount = double.tryParse(amountStr) ?? 0.0;
      emit((state as AuctionLoaded).copyWith(bidAmount: amount));
    }
  }

  void placeBid(String token) {
    if (state is AuctionLoaded) {
      final amount = (state as AuctionLoaded).bidAmount;
      if (amount > 0) {
        placeBidUseCase(PlaceBidParams(amount: amount, token: token));
        // Reset bid amount after placing bid
        emit((state as AuctionLoaded).copyWith(bidAmount: 0.0));
      }
    }
  }

  @override
  Future<void> close() {
    _auctionSubscription?.cancel();
    return super.close();
  }
}
