import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isAdmin;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFF3737),
      automaticallyImplyLeading: false,
      title: Row(
        children: [
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
          if (isAdmin) ...[
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
