import 'package:equatable/equatable.dart';

import '../../domain/entities/auction_item.dart';

/// Base class for all auction states.
abstract class AuctionState extends Equatable {
  const AuctionState();

  @override
  List<Object?> get props => [];
}

/// The initial state of the auction.
class AuctionInitial extends AuctionState {}

/// The state when the auction is connecting or loading data.
class AuctionLoading extends AuctionState {}

/// The state when the auction data has been successfully loaded.
class AuctionLoaded extends AuctionState {
  /// The current auction item details.
  final AuctionItem item;

  /// The current bid amount entered by the user.
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

/// The state when an error occurs during the auction process.
class AuctionError extends AuctionState {
  /// The error message.
  final String message;

  const AuctionError(this.message);

  @override
  List<Object?> get props => [message];
}
