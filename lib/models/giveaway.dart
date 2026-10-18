import 'package:flutter/foundation.dart';

class Giveaway {
  final int id;
  final String title;
  final String worth;
  final String thumbnail;
  final String image;
  final String description;
  final String instructions;
  final String openGiveawayUrl;
  final String publishedDate;
  final String type;
  final String platforms;
  final String endDate;
  final int users;
  final String status;
  final String gamerpowerUrl;

  const Giveaway({
    required this.id,
    required this.title,
    required this.worth,
    required this.thumbnail,
    required this.image,
    required this.description,
    required this.instructions,
    required this.openGiveawayUrl,
    required this.publishedDate,
    required this.type,
    required this.platforms,
    required this.endDate,
    required this.users,
    required this.status,
    required this.gamerpowerUrl,
  });

  /// Optimized thumbnail for GridView cards.
  /// Uses thumbnail (small payload) and wsrv.nl proxy on web for CORS compliance.
  String get displayImageUrl {
    final rawUrl = (thumbnail.isNotEmpty ? thumbnail : image).trim();
    if (rawUrl.isEmpty) return '';
    if (kIsWeb) {
      return 'https://wsrv.nl/?url=${Uri.encodeComponent(rawUrl)}';
    }
    return rawUrl;
  }

  /// High-resolution image for detail screen header.
  String get displayDetailImageUrl {
    final rawUrl = (image.isNotEmpty ? image : thumbnail).trim();
    if (rawUrl.isEmpty) return '';
    if (kIsWeb) {
      return 'https://wsrv.nl/?url=${Uri.encodeComponent(rawUrl)}';
    }
    return rawUrl;
  }

  factory Giveaway.fromJson(Map<String, dynamic> json) {
    return Giveaway(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title'] as String? ?? 'Untitled Giveaway',
      worth: json['worth'] as String? ?? 'N/A',
      thumbnail: json['thumbnail'] as String? ?? '',
      image: json['image'] as String? ?? '',
      description: json['description'] as String? ?? 'No description available.',
      instructions: json['instructions'] as String? ?? 'No instructions provided.',
      openGiveawayUrl: json['open_giveaway_url'] as String? ?? json['open_giveaway'] as String? ?? '',
      publishedDate: json['published_date'] as String? ?? '',
      type: json['type'] as String? ?? 'Game',
      platforms: json['platforms'] as String? ?? 'PC',
      endDate: json['end_date'] as String? ?? 'N/A',
      users: json['users'] is int ? json['users'] : int.tryParse(json['users']?.toString() ?? '0') ?? 0,
      status: json['status'] as String? ?? 'Active',
      gamerpowerUrl: json['gamerpower_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'worth': worth,
      'thumbnail': thumbnail,
      'image': image,
      'description': description,
      'instructions': instructions,
      'open_giveaway_url': openGiveawayUrl,
      'published_date': publishedDate,
      'type': type,
      'platforms': platforms,
      'end_date': endDate,
      'users': users,
      'status': status,
      'gamerpower_url': gamerpowerUrl,
    };
  }
}
