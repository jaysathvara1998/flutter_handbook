import 'package:flutter/material.dart';
import 'package:flutter_handbook/core/constants/route_constants.dart';
import 'package:flutter_handbook/core/utils/navigation_util.dart';
import 'package:flutter_handbook/models/topic.dart';
import 'package:flutter_handbook/services/topic_service.dart';
import 'package:flutter_handbook/widgets/topic_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Handbook'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              NavigationUtil.goToPath(Routes.settings);
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Topic>>(
        stream: TopicService.getTopicsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final topics = snapshot.data ?? [];

          if (topics.isEmpty) {
            return const Center(
                child: Text('No topics found. Add your first topic!'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TopicCard(
                  topic: topic,
                  onReadMoreTap: () {
                    NavigationUtil.goToNamed(
                      RouteName.topic,
                      params: {'id': topic.id},
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
