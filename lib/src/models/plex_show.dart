import 'package:sb_plex_api/src/models/plex_media_item.dart';

enum PlexShowSequence {
  Title,
  Added,
  Updated,
  OriginallyAvailable,
}

class PlexShow extends PlexMediaItem {
  PlexShow(Map<String, dynamic> showMap)
      : bannerKey = showMap['banner'] ?? '',
        themeKey = showMap['theme'] ?? '',
        super(
            key: showMap['key'] ?? '',
            title: showMap['title'] ?? '',
            titleSort: showMap['titleSort'] ?? showMap['title'] ?? '',
            sectionIds: [showMap['librarySectionID'] ?? -1],
            uuid: showMap['guid'] ?? '',
            thumbKey: showMap['thumb'] ?? '',
            artKey: showMap['art'] ?? '',
            addedAt: DateTime.fromMillisecondsSinceEpoch((showMap['addedAt'] ?? 0) * 1000),
            updatedAt: DateTime.fromMillisecondsSinceEpoch((showMap['updatedAt'] ?? 0) * 1000),
            originallyAt: DateTime.tryParse(showMap['originallyAvailableAt'] ?? ''),
            );

  final String bannerKey;
  final String themeKey;
}
