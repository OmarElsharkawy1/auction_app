import 'package:frontend/core/bloc/locale/locale_cubit.dart';
import 'package:frontend/features/auction/data/datasources/auction_remote_data_source.dart';
import 'package:frontend/features/auction/data/repositories/auction_repository_impl.dart';
import 'package:frontend/features/auction/domain/repositories/auction_repository.dart';
import 'package:frontend/features/auction/domain/usecases/connect_auction_usecase.dart';
import 'package:frontend/features/auction/domain/usecases/disconnect_auction_usecase.dart';
import 'package:frontend/features/auction/domain/usecases/get_auction_updates_usecase.dart';
import 'package:frontend/features/auction/domain/usecases/place_bid_usecase.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_cubit.dart';
import 'package:frontend/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:frontend/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:frontend/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/logout_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/register_usecase.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // Cubit
  sl.registerLazySingleton(
    () => AuthCubit(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      checkAuthUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));

  // Repository
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Features - Auction
  // Cubit
  sl.registerFactory(
    () => AuctionCubit(
      connectAuctionUseCase: sl(),
      disconnectAuctionUseCase: sl(),
      placeBidUseCase: sl(),
      getAuctionUpdatesUseCase: sl(),
    ),
  );
  sl.registerFactory(() => LocaleCubit());

  // Use cases
  sl.registerLazySingleton(() => ConnectAuctionUseCase(sl()));
  sl.registerLazySingleton(() => DisconnectAuctionUseCase(sl()));
  sl.registerLazySingleton(() => PlaceBidUseCase(sl()));
  sl.registerLazySingleton(() => GetAuctionUpdatesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuctionRepository>(
    () => AuctionRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuctionRemoteDataSource>(
    () => AuctionRemoteDataSourceImpl(),
  );

  //! Core

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // Socket.io client will be created in RemoteDataSource or injected here if singleton
}
