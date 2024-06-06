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
    const List<BottomNavigationBarItem> adminItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Início',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart),
        label: 'Relatórios',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Perfil',
      ),
    ];

    const List<BottomNavigationBarItem> userItems = [
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
    ];

    return BottomNavigationBar(
      items: userType == 'admin' ? adminItems : userItems,
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFFFF3737),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        onTap(index);
      },
    );
  }
}
