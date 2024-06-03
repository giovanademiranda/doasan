import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String userType;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Agendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notificações',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFFFF3737),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) {
          if (userType == 'admin') {
            Navigator.of(context).pushReplacementNamed('/admin_home');
          } else {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        } else if (index == 1) {
          onTap(index);
        } else if (index == 3) {
          Navigator.of(context)
              .pushReplacementNamed('/profile', arguments: userType);
        } else if (index == 2) {
          Navigator.of(context).pushReplacementNamed('/notifications');
        }
      },
    );
  }
}
