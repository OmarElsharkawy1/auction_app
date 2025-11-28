import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/injection_container.dart' as di;
import 'features/auction/presentatiom/auction_cubit/auction_cubit.dart';
import 'features/auction/presentatiom/auction_screen.dart';
import 'features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'features/auth/presentation/auth_cubit/auth_state.dart';
import 'features/auth/presentation/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()..checkAuth()),
        BlocProvider(create: (_) => di.sl<AuctionCubit>()),
      ],
      child: MaterialApp(
        title: 'Live Auction',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return AuctionScreen();
            }
            return AuthScreen();
          },
        ),
      ),
    );
  }
}
