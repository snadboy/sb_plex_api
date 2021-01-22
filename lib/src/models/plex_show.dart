class PlexShow {
  PlexShow(Map<String, dynamic> showMap) : title = showMap['title'] ?? '',
    key = showMap['key'] ?? '',
    sectionIds = [showMap['librarySectionID'] ?? -1],
    uuid = showMap['guid'] ?? '',
    thumbKey = showMap['thumb'] ?? '',
    artKey = showMap['art'] ?? '',
    bannerKey = showMap['banner'] ?? '',
    themeKey = showMap['theme'] ?? '',
    addedAt = DateTime.fromMillisecondsSinceEpoch((showMap['addedAt'] ?? 0) * 1000),
    updatedAt = DateTime.fromMillisecondsSinceEpoch((showMap['updatedAt'] ?? 0) * 1000);

  final String title;
  final String key;
  final String uuid;
  final List<int> sectionIds;
  final String thumbKey;
  final String artKey;
  final String bannerKey;
  final String themeKey;
  final DateTime addedAt;
  final DateTime updatedAt;

  @override
  bool operator ==(ps) => uuid == ps.uuid;
}
