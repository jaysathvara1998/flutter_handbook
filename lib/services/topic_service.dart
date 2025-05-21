import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/topic.dart';

class TopicService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Stream of all topics
  static Stream<List<Topic>> getTopicsStream() {
    return _firestore.collection('topics').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Topic.fromFirestore(doc)).toList();
    });
  }

  /// Fetch a single topic by ID
  static Future<Topic?> getTopicById(String id) async {
    final doc = await _firestore.collection('topics').doc(id).get();
    if (doc.exists) {
      return Topic.fromFirestore(doc);
    }
    return null;
  }
}
