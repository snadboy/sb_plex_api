class PlexMediaItem {
  PlexMediaItem({
    this.title,
    this.key,
    this.uuid,
    this.sectionIds,
    this.thumbKey,
    this.artKey,
    this.addedAt,
    this.updatedAt,
  });

  final String title;
  final String key;
  final String uuid;
  final List<int> sectionIds;
  final String thumbKey;
  final String artKey;
  final DateTime addedAt;
  final DateTime updatedAt;

  // final String bannerKey;
  // final String themeKey;

  @override
  bool operator ==(ps) => uuid == ps.uuid;

}
