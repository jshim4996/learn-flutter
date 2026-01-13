// STEP 5-1 ~ 5-4: ListView, GridView, ScrollView 예제

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('List & Grid'),
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'ListView'),
                Tab(text: 'GridView'),
                Tab(text: 'Scroll'),
                Tab(text: 'Sliver'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ListViewExample(),
              GridViewExample(),
              ScrollViewExample(),
              SliverExample(),
            ],
          ),
        ),
      ),
    );
  }
}

// ========================================
// 5-1. ListView 예제
// ========================================

class ListViewExample extends StatelessWidget {
  const ListViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(100, (index) => 'Item ${index + 1}');

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.primaries[index % Colors.primaries.length],
            child: Text('${index + 1}'),
          ),
          title: Text(items[index]),
          subtitle: Text('Subtitle for item ${index + 1}'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tapped ${items[index]}')),
            );
          },
        );
      },
    );
  }
}

// ========================================
// 5-2. GridView 예제
// ========================================

class GridViewExample extends StatelessWidget {
  const GridViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image,
                  size: 48,
                  color: Colors.primaries[index % Colors.primaries.length],
                ),
                const SizedBox(height: 8),
                Text('Item ${index + 1}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ========================================
// 5-3. SingleChildScrollView 예제
// ========================================

class ScrollViewExample extends StatelessWidget {
  const ScrollViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 헤더
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 중첩 ListView (shrinkWrap 필수!)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Nested Item ${index + 1}'),
              );
            },
          ),

          const SizedBox(height: 16),

          // 추가 컨텐츠
          ...List.generate(
            5,
            (index) => Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('Box ${index + 1}')),
            ),
          ),
        ],
      ),
    );
  }
}

// ========================================
// 5-4. CustomScrollView / Sliver 예제
// ========================================

class SliverExample extends StatelessWidget {
  const SliverExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar - 스크롤시 접히는 앱바
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Sliver Demo'),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),

        // SliverToBoxAdapter - 일반 위젯
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'This is a header section',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // SliverList
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              leading: Icon(Icons.star, color: Colors.amber),
              title: Text('Sliver List Item ${index + 1}'),
            ),
            childCount: 10,
          ),
        ),

        // 또 다른 헤더
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: const Text(
              'Grid Section',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // SliverGrid
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              color: Colors.primaries[index % Colors.primaries.length],
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            childCount: 9,
          ),
        ),

        // 하단 여백
        const SliverToBoxAdapter(
          child: SizedBox(height: 50),
        ),
      ],
    );
  }
}
