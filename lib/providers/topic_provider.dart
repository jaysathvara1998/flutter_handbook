import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopicState {
  final String? id;
  final String? title;
  final String? description;
  final String? example;
  final String? codeLanguage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TopicState({
    this.id,
    this.title,
    this.description,
    this.example,
    this.codeLanguage,
    this.createdAt,
    this.updatedAt,
  });

  TopicState copyWith({
    String? id,
    String? title,
    String? description,
    String? example,
    String? codeLanguage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TopicState(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      example: example ?? this.example,
      codeLanguage: codeLanguage ?? this.codeLanguage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class TopicNotifier extends StateNotifier<TopicState> {
  final Ref ref;

  TopicNotifier({required this.ref}) : super(TopicState());
}

final topicController = StateNotifierProvider<TopicNotifier, TopicState>((ref) {
  return TopicNotifier(ref: ref);
});
