import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_cubit.dart';
import 'package:frontend/features/auction/presentatiom/auction_cubit/auction_state.dart';
import 'package:frontend/features/auction/presentatiom/widgets/auction_app_bar.dart';
import 'package:frontend/features/auction/presentatiom/widgets/auction_info.dart';
import 'package:frontend/features/auction/presentatiom/widgets/bid_input.dart';
import 'package:frontend/features/auction/presentatiom/widgets/bid_list.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:go_router/go_router.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key});

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  late ScrollController _scrollController;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    // Connect to auction when screen initializes
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      context.read<AuctionCubit>().connect(authState.token);
    }
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;

    final isCollapsed = _scrollController.offset > (250 - kToolbarHeight);
    if (isCollapsed != _isCollapsed) {
      setState(() {
        _isCollapsed = isCollapsed;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuctionCubit, AuctionState>(
        builder: (context, state) {
          if (state is AuctionLoading || state is AuctionInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AuctionError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is AuctionLoaded) {
            final item = state.item;
            final bids = (item['bids'] as List).cast<Map<String, dynamic>>();

            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      AuctionAppBar(
                        isCollapsed: _isCollapsed,
                        item: item,
                        onLogout: () {
                          context.read<AuctionCubit>().disconnect();
                          context.read<AuthCubit>().logout();
                          context.go('/');
                        },
                      ),
                      AuctionInfo(item: item),
                      BidList(bids: bids),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 100),
                      ), // Space for bottom bar
                    ],
                  ),
                ),
                const BidInput(),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
