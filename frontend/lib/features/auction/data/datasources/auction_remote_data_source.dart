import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/config.dart';
import 'package:frontend/features/auction/data/models/auction_item_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as wio;

/// Interface for remote auction operations.
abstract class AuctionRemoteDataSource {
  /// A stream of real-time auction updates.
  Stream<AuctionItemModel> get auctionUpdates;

  /// Connects to the auction WebSocket with the given [token].
  void connect(String token);

  /// Disconnects from the auction WebSocket.
  void disconnect();

  /// Places a bid of [amount] with the given [token].
  void placeBid(double amount, String token);
}

class AuctionRemoteDataSourceImpl implements AuctionRemoteDataSource {
  wio.Socket? _socket;
  final _auctionStreamController =
      StreamController<AuctionItemModel>.broadcast();

  String get _baseUrl => Config.baseUrl;

  @override
  Stream<AuctionItemModel> get auctionUpdates =>
      _auctionStreamController.stream;

  @override
  void connect(String token) {
    if (_socket != null && _socket!.connected) return;

    _socket = wio.io(_baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'token': token},
    });

    _socket!.connect();

    _socket!.onConnect((_) {
      debugPrint('Connected to Socket.io');
    });

    _socket!.on('auctionUpdate', (data) {
      try {
        final item = AuctionItemModel.fromJson(data);
        _auctionStreamController.add(item);
      } catch (e) {
        debugPrint('Error parsing auction update: $e');
      }
    });

    _socket!.onDisconnect((_) => debugPrint('Disconnected'));
  }

  @override
  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  @override
  void placeBid(double amount, String token) {
    _socket?.emit('placeBid', {'amount': amount, 'token': token});
  }
}
