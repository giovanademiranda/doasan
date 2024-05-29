import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../data/post_model.dart';
import '../widgets/add_campaign_button.dart';

class HomePage extends StatelessWidget {
  final String userType;

  const HomePage({super.key, required this.userType});

  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(seconds: 2));
    return mockPosts;
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
            if (userType == 'admin') ...[
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userType == 'admin') const AddCampaignButton(),
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
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: const Color(0xFFFF3737),
        onTap: (index) {},
      ),
    );
  }
}
