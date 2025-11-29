import 'package:equatable/equatable.dart';

import '../../domain/entities/auction_item.dart';

abstract class AuctionState extends Equatable {
  const AuctionState();

  @override
  List<Object?> get props => [];
}

class AuctionInitial extends AuctionState {}

class AuctionLoading extends AuctionState {}

class AuctionLoaded extends AuctionState {
  final AuctionItem item;
  final double bidAmount;

  const AuctionLoaded(this.item, {this.bidAmount = 0.0});

  AuctionLoaded copyWith({AuctionItem? item, double? bidAmount}) {
    return AuctionLoaded(
      item ?? this.item,
      bidAmount: bidAmount ?? this.bidAmount,
    );
  }

  @override
  List<Object?> get props => [item, bidAmount];
}

class AuctionError extends AuctionState {
  final String message;

  const AuctionError(this.message);

  @override
  List<Object?> get props => [message];
}
