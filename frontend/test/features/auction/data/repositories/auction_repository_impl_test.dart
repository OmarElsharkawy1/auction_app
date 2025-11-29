import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/auction/data/datasources/auction_remote_data_source.dart';
import 'package:frontend/features/auction/data/models/auction_item_model.dart';
import 'package:frontend/features/auction/data/repositories/auction_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

/// Mock for [AuctionRemoteDataSource].
class MockAuctionRemoteDataSource extends Mock
    implements AuctionRemoteDataSource {}

/// Tests for [AuctionRepositoryImpl].
void main() {
  late AuctionRepositoryImpl repository;
  late MockAuctionRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuctionRemoteDataSource();
    repository = AuctionRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tToken = 'testtoken';
  const tAmount = 100.0;
  final tAuctionItemModel = AuctionItemModel(
    id: 1,
    title: 'Test Item',
    description: 'Test Description',
    imageUrl: 'http://example.com/image.png',
    currentPrice: 100.0,
    highestBidder: 'testuser',
    bids: const [],
  );

  group('auctionUpdates', () {
    test('should return stream of auction items', () {
      // arrange
      when(
        () => mockRemoteDataSource.auctionUpdates,
      ).thenAnswer((_) => Stream.value(tAuctionItemModel));

      // act
      final result = repository.auctionUpdates;

      // assert
      expect(result, emits(tAuctionItemModel));
    });
  });

  group('connect', () {
    test('should call remote connect', () {
      // arrange
      when(() => mockRemoteDataSource.connect(tToken)).thenReturn(null);

      // act
      repository.connect(tToken);

      // assert
      verify(() => mockRemoteDataSource.connect(tToken)).called(1);
    });
  });

  group('disconnect', () {
    test('should call remote disconnect', () {
      // arrange
      when(() => mockRemoteDataSource.disconnect()).thenReturn(null);

      // act
      repository.disconnect();

      // assert
      verify(() => mockRemoteDataSource.disconnect()).called(1);
    });
  });

  group('placeBid', () {
    test('should call remote placeBid', () {
      // arrange
      when(
        () => mockRemoteDataSource.placeBid(tAmount, tToken),
      ).thenReturn(null);

      // act
      repository.placeBid(tAmount, tToken);

      // assert
      verify(() => mockRemoteDataSource.placeBid(tAmount, tToken)).called(1);
    });
  });
}
