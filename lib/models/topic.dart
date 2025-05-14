// topic_model.dart - Model class for Flutter topics

import 'package:cloud_firestore/cloud_firestore.dart';

class Topic {
  String id;
  String title;
  String description; // Will contain HTML formatted content
  String example; // Will contain code with syntax highlighting
  String
      codeLanguage; // Language of the code example (e.g., 'dart', 'javascript')
  DateTime createdAt;
  DateTime updatedAt;

  Topic({
    this.id = '',
    required this.title,
    required this.description,
    this.example = '',
    this.codeLanguage = 'dart',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Create a Topic from a Firestore document
  factory Topic.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Topic(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      example: data['example'] ?? '',
      codeLanguage: data['codeLanguage'] ?? 'dart',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert Topic to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'example': example,
      'codeLanguage': codeLanguage,
      'createdAt': createdAt,
      'updatedAt': DateTime.now(),
    };
  }
}
