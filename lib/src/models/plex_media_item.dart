class PlexMediaItem {
  PlexMediaItem({
    this.title,
    this.titleSort,
    this.key,
    this.uuid,
    this.sectionIds,
    this.thumbKey,
    this.artKey,
    this.addedAt,
    this.updatedAt,
    this.originallyAt,
  });

  final String title;
  final String titleSort;
  final String key;
  final String uuid;
  final List<int> sectionIds;
  final String thumbKey;
  final String artKey;
  final DateTime addedAt;
  final DateTime updatedAt;
  final DateTime originallyAt;

  @override
  bool operator ==(ps) => uuid == ps.uuid;
}
