import 'dart:async';

import 'package:flutter/foundation.dart';

/// A [ChangeNotifier] that notifies listeners when a [Stream] emits a value.
///
/// This is used to trigger a router refresh when the authentication state changes.
class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [GoRouterRefreshStream] that listens to the provided [stream].
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
