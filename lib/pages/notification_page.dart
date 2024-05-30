import 'package:flutter/material.dart';

import '../data/mock_data.dart' as mockData;
import '../data/notification_model.dart' as customNotification;

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  Future<List<customNotification.Notification>> fetchNotifications() async {
    await Future.delayed(const Duration(seconds: 2));
    return mockData.mockNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            const Text(
              'Doasan - Sorocaba',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Notificações',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<customNotification.Notification>>(
                future: fetchNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar dados'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhuma notificação encontrada'));
                  } else {
                    final notifications = snapshot.data!;
                    return ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.notifications),
                                    const SizedBox(width: 8),
                                    Text(
                                      notification.message,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text('Data: ${notification.date}'),
                                const SizedBox(height: 8),
                                Text('Hora: ${notification.time}'),
                                const SizedBox(height: 8),
                                Text('Local: ${notification.location}'),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
