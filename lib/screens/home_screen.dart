import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_handbook/models/topic.dart';
import 'package:flutter_handbook/screens/settings_screen.dart';
import 'package:flutter_handbook/screens/topic_detail_screen.dart';
import 'package:flutter_handbook/widgets/topic_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/topic_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      ref.read(topicController.notifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(topicController);
    final controller = ref.read(topicController.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Handbook'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('topics').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text('No topics found. Add your first topic!'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                final topic = Topic.fromFirestore(doc);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TopicCard(
                    topic: topic,
                    onReadMoreTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopicDetailScreen(topic: topic),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }),
    );
  }

  // List<Topic> _getTopics() {
  //   return [
  //     Topic(
  //       id: '1',
  //       title: 'Getting Started with Flutter',
  //       overview:
  //           'Learn how to set up your development environment and create your first Flutter app.',
  //       detailedDescription:
  //           'Flutter is Google\'s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. In this section, we\'ll guide you through installing Flutter, setting up your IDE, and creating a basic Flutter application.\n\nWe\'ll cover the Flutter SDK installation, configuring Android Studio or VS Code, and running your first app on an emulator or physical device. You\'ll also learn about Flutter\'s hot reload feature that helps you quickly experiment, build UIs, add features, and fix bugs.',
  //     ),
  //     Topic(
  //       id: '2',
  //       title: 'Flutter Widgets',
  //       overview:
  //           'Understand the fundamental building blocks of Flutter applications.',
  //       detailedDescription:
  //           'Widgets are the central class hierarchy in the Flutter framework. A widget is an immutable description of part of a user interface. Widgets can be inflated into elements, which manage the underlying render tree.\n\nIn this section, we\'ll explore different types of widgets including StatelessWidget and StatefulWidget. You\'ll learn about layout widgets, container widgets, text widgets, button widgets, and many more. We\'ll also cover how to combine these widgets to create complex UIs and how to style them using themes.',
  //     ),
  //     Topic(
  //       id: '3',
  //       title: 'State Management',
  //       overview:
  //           'Explore various state management approaches in Flutter including Riverpod.',
  //       detailedDescription:
  //           'State management is a crucial aspect of Flutter development. It refers to how you manage the state of your widgets and how you share data between them.\n\nIn this section, we\'ll focus on Riverpod, a state management solution that improves upon Provider. You\'ll learn how to use Providers, StateNotifiers, and StateProviders. We\'ll also cover when to use each type of provider and how to organize your state management code. Additionally, we\'ll compare Riverpod with other state management solutions like Provider, Bloc, and GetX to help you understand the benefits and trade-offs of each approach.',
  //     ),
  //     Topic(
  //       id: '4',
  //       title: 'Navigation & Routing',
  //       overview:
  //           'Learn how to navigate between screens and implement routing in Flutter.',
  //       detailedDescription:
  //           'Navigation is an essential part of any mobile application. Flutter provides a powerful navigation system that allows you to move between different screens.\n\nIn this section, we\'ll cover basic navigation using Navigator 1.0, including pushing and popping routes. We\'ll also explore Navigator 2.0 (or Router) for more complex navigation scenarios. You\'ll learn how to pass data between screens, how to implement deep linking, and how to handle the back button on Android. Additionally, we\'ll look at navigation packages like go_router and auto_route that can simplify complex navigation requirements.',
  //     ),
  //   ];
  // }
}
