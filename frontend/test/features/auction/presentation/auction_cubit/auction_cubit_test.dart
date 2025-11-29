import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/auction/domain/entities/auction_item.dart';
import 'package:frontend/features/auction/domain/usecases/connect_auction_usecase.dart';
import 'package:frontend/features/auction/domain/usecases/disconnect_auction_usecase.dart';
import 'package:frontend/features/auction/domain/usecases/get_auction_updates_usecase.dart';
import 'package:frontend/features/auction/domain/usecases/place_bid_usecase.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_cubit.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_state.dart';
import 'package:mocktail/mocktail.dart';

/// Mock for [ConnectAuctionUseCase].
class MockConnectAuctionUseCase extends Mock implements ConnectAuctionUseCase {}

/// Mock for [DisconnectAuctionUseCase].
class MockDisconnectAuctionUseCase extends Mock
    implements DisconnectAuctionUseCase {}

/// Mock for [GetAuctionUpdatesUseCase].
class MockGetAuctionUpdatesUseCase extends Mock
    implements GetAuctionUpdatesUseCase {}

/// Mock for [PlaceBidUseCase].
class MockPlaceBidUseCase extends Mock implements PlaceBidUseCase {}

/// Tests for [AuctionCubit].
void main() {
  late AuctionCubit cubit;
  late MockConnectAuctionUseCase mockConnectAuctionUseCase;
  late MockDisconnectAuctionUseCase mockDisconnectAuctionUseCase;
  late MockGetAuctionUpdatesUseCase mockGetAuctionUpdatesUseCase;
  late MockPlaceBidUseCase mockPlaceBidUseCase;

  setUp(() {
    mockConnectAuctionUseCase = MockConnectAuctionUseCase();
    mockDisconnectAuctionUseCase = MockDisconnectAuctionUseCase();
    mockGetAuctionUpdatesUseCase = MockGetAuctionUpdatesUseCase();
    mockPlaceBidUseCase = MockPlaceBidUseCase();
    cubit = AuctionCubit(
      connectAuctionUseCase: mockConnectAuctionUseCase,
      disconnectAuctionUseCase: mockDisconnectAuctionUseCase,
      getAuctionUpdatesUseCase: mockGetAuctionUpdatesUseCase,
      placeBidUseCase: mockPlaceBidUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state is AuctionInitial', () {
    expect(cubit.state, AuctionInitial());
  });

  final tAuctionItem = AuctionItem(
    id: 1,
    title: 'Test Item',
    description: 'Test Description',
    imageUrl: 'http://example.com/image.png',
    currentPrice: 100.0,
    highestBidder: 'testuser',
    bids: const [],
  );

  group('connect', () {
    blocTest<AuctionCubit, AuctionState>(
      'emits [AuctionLoading, AuctionLoaded] when updates are received',
      build: () {
        when(
          () => mockConnectAuctionUseCase(
            const ConnectAuctionParams(token: 'testtoken'),
          ),
        ).thenAnswer((_) async => {});
        when(
          () => mockGetAuctionUpdatesUseCase(NoParams()),
        ).thenAnswer((_) => Stream.value(tAuctionItem));
        return cubit;
      },
      act: (cubit) => cubit.connect('testtoken'),
      expect: () => [AuctionLoading(), AuctionLoaded(tAuctionItem)],
    );
  });

  group('placeBid', () {
    blocTest<AuctionCubit, AuctionState>(
      'calls placeBidUseCase',
      build: () {
        when(
          () => mockPlaceBidUseCase(
            const PlaceBidParams(amount: 150.0, token: 'testtoken'),
          ),
        ).thenAnswer((_) async => {});
        return cubit;
      },
      seed: () => AuctionLoaded(tAuctionItem, bidAmount: 150.0),
      act: (cubit) => cubit.placeBid('testtoken'),
      verify: (_) {
        verify(
          () => mockPlaceBidUseCase(
            const PlaceBidParams(amount: 150.0, token: 'testtoken'),
          ),
        ).called(1);
      },
    );
  });
}
