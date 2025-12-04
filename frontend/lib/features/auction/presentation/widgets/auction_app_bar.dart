import 'package:flutter/material.dart';
import 'package:frontend/core/components/language_switcher.dart';

import '../../domain/entities/auction_item.dart';

/// A custom app bar for the auction screen.
///
/// This app bar displays the auction item's image and title. It collapses as the user scrolls,
/// changing its appearance to ensure visibility. It also includes a language switcher and a logout button.
class AuctionAppBar extends StatelessWidget {
  /// Whether the app bar is currently collapsed.
  final bool isCollapsed;

  /// The auction item to display.
  final AuctionItem item;

  /// Callback function to handle logout.
  final VoidCallback onLogout;

  const AuctionAppBar({
    super.key,
    required this.isCollapsed,
    required this.item,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      iconTheme: IconThemeData(
        color: isCollapsed ? Colors.black : Colors.white,
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          item.title,
          style: TextStyle(
            color: isCollapsed ? Colors.black : Colors.white,
            shadows: isCollapsed
                ? null
                : const [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black45,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 50),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        LanguageSwitcher(iconColor: isCollapsed ? Colors.black : Colors.white),
        IconButton(
          icon: Icon(
            Icons.logout,
            color: isCollapsed ? Colors.black : Colors.white,
          ),
          onPressed: onLogout,
        ),
      ],
    );
  }
}
