import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isAdmin;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isAdmin = false,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFF3737),
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          Image.network(
            'https://cdn-icons-png.flaticon.com/512/2679/2679284.png',
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),

        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
