// STEP 5-9 ~ 5-15: Image, Icon, Card, AppBar, BottomNav, Drawer 예제

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DisplayWidgetsPage(),
    const CardsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text('Navigation Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),

      // Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'John Doe',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'john@example.com',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text('Cards'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 2);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // Body
      body: _pages[_currentIndex],

      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ========================================
// 5-9, 5-10. Image, Icon 페이지
// ========================================

class DisplayWidgetsPage extends StatelessWidget {
  const DisplayWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('=== Images ===',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          // 네트워크 이미지
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/300/200',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 150,
                  color: Colors.grey.shade200,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey.shade200,
                  child: const Center(child: Icon(Icons.error)),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          const Text('=== Icons ===',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          // 다양한 아이콘
          const Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              Icon(Icons.home, size: 32),
              Icon(Icons.favorite, size: 32, color: Colors.red),
              Icon(Icons.star, size: 32, color: Colors.amber),
              Icon(Icons.settings, size: 32, color: Colors.grey),
              Icon(Icons.search, size: 32, color: Colors.blue),
              Icon(Icons.person, size: 32, color: Colors.green),
            ],
          ),

          const SizedBox(height: 24),

          const Text('=== ListTile ===',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          // ListTile 예제
          const ListTile(
            leading: CircleAvatar(child: Text('A')),
            title: Text('List Tile Title'),
            subtitle: Text('This is a subtitle'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const ListTile(
            leading: Icon(Icons.music_note, color: Colors.purple),
            title: Text('Music'),
            subtitle: Text('Now playing'),
            trailing: Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}

// ========================================
// 5-11. Card 페이지
// ========================================

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 기본 Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Basic Card',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('This is a basic card with some content.'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {}, child: const Text('CANCEL')),
                    TextButton(onPressed: () {}, child: const Text('OK')),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // 이미지 Card
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Image.network(
                'https://picsum.photos/400/200',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const ListTile(
                title: Text('Image Card'),
                subtitle: Text('A card with an image header'),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    TextButton(onPressed: () {}, child: const Text('MORE')),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 스타일 Card
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.blue.shade50,
          child: const Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(Icons.star, size: 48, color: Colors.amber),
                SizedBox(height: 16),
                Text(
                  'Styled Card',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('Custom shape and elevation'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ========================================
// Settings 페이지
// ========================================

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          leading: Icon(Icons.person),
          title: Text('Account'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const ListTile(
          leading: Icon(Icons.security),
          title: Text('Privacy'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.help),
          title: Text('Help'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const ListTile(
          leading: Icon(Icons.info),
          title: Text('About'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
