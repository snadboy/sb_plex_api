class PlexMovie {
  PlexMovie(Map<String, dynamic> movieMap):title = movieMap['title'] ?? '',
    key = movieMap['key'] ?? '',
    sectionIds = [movieMap['librarySectionID'] ?? -1],
    uuid = movieMap['guid'] ?? '',
    thumbKey = movieMap['thumb'] ?? '',
    artKey = movieMap['art'] ?? '',
    addedAt = DateTime.fromMillisecondsSinceEpoch((movieMap['addedAt'] ?? 0) * 1000),
    updatedAt = DateTime.fromMillisecondsSinceEpoch((movieMap['updatedAt'] ?? 0) * 1000);

  final String title;
  final String key;
  final String uuid;
  final List<int> sectionIds;
  final String thumbKey;
  final String artKey;
  final DateTime addedAt;
  final DateTime updatedAt;

  @override
  bool operator ==(pm) => uuid == pm.uuid;
}
