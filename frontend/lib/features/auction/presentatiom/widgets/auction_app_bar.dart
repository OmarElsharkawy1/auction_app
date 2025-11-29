import 'package:flutter/material.dart';

class AuctionAppBar extends StatelessWidget {
  final bool isCollapsed;
  final Map<String, dynamic> item;
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
          item['title'],
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
              item['imageUrl'],
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
