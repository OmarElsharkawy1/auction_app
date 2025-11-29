import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/l10n/app_localizations.dart';

import 'core/bloc/locale/locale_cubit.dart';
import 'core/bloc/locale/locale_state.dart';
import 'core/observers/simple_bloc_observer.dart';
import 'core/router/app_router.dart';
import 'core/services/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'features/auction/presentatiom/auction_cubit/auction_cubit.dart';
import 'features/auth/presentation/auth_cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = SimpleBlocObserver();
  // Start checking auth immediately
  di.sl<AuthCubit>().checkAuth();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di.sl<AuthCubit>()),
        BlocProvider(create: (_) => di.sl<AuctionCubit>()),
        BlocProvider(create: (_) => di.sl<LocaleCubit>()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Live Auction',
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            locale: state.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('ar'), // Arabic
              Locale('es'), // Spanish
            ],
          );
        },
      ),
    );
  }
}
