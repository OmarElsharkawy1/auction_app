import 'package:equatable/equatable.dart';

/// Base class for all use cases.
///
/// [T] is the return type of the use case.
/// [Params] is the type of parameters passed to the use case.
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

/// Base class for use cases that return a [Stream].
abstract class StreamUseCase<T, Params> {
  Stream<T> call(Params params);
}

/// A placeholder type for use cases that do not require any parameters.
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
