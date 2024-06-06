import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../data/post_model.dart';
import '../data/user_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomeAdminPage extends StatelessWidget {
  final User user;

  const HomeAdminPage({super.key, required this.user});

  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(seconds: 2));
    return mockPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Doasan - Sorocaba',
        isAdmin: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Adicionar campanha'),
              onPressed: () {
                Navigator.of(context).pushNamed('/add_campaign');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFFF3737),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Color(0xFFFF3737)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Campanhas de Doação de Sangue',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: fetchPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar dados'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhuma postagem encontrada'));
                  } else {
                    final posts = snapshot.data!;
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.person),
                                    const SizedBox(width: 8),
                                    Text(
                                      post.username,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(post.description),
                                const SizedBox(height: 8),
                                Image.network(post.imageUrl),
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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context)
                .pushReplacementNamed('/home_admin', arguments: {'user': user});
          } else if (index == 1) {
            Navigator.of(context)
                .pushReplacementNamed('/reports', arguments: {'user': user});
          } else if (index == 2) {
            Navigator.of(context)
                .pushReplacementNamed('/profile', arguments: {'user': user});
          }
        },
        userType: 'admin',
      ),
    );
  }
}
