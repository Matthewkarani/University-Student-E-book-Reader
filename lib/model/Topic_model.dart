
import 'package:cloud_firestore/cloud_firestore.dart';

class Topic {
  late final String? topic_title;
  late final String? topic_Description;
  late final bool? isTopic;
  late final List? videoslinks;
  late final List? notesLinks;

  Topic({
    this.topic_title,
    this.topic_Description,
    this.isTopic,
    this.notesLinks,
    this.videoslinks
  });

  factory Topic.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Topic(
        topic_title: data?['topic_title'],
        topic_Description: data?['topic_description'],
        notesLinks: data?['notesLinks'],
        videoslinks: data?['videoslinks'],
        isTopic: data?['isTopic']
    );




  }
  Map<String, dynamic> toFirestore() {
    return {
      if (topic_Description != null) "topic_title": topic_title,
      if (topic_title != null) "topic_description": topic_Description,
      if (isTopic != null) "IsTopic": isTopic,
      if (videoslinks != null) "videoslinks": videoslinks,
      if (notesLinks != null) "notesLinks": notesLinks

    };
  }

}