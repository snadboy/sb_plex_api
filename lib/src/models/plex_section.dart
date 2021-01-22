class PlexSection {
  PlexSection(Map<String, dynamic> sectionMap) {
    title = sectionMap['title'] ?? '';
    id = int.tryParse(sectionMap['key']) ?? -1;
    type = sectionMap['type'] ?? '';
    uuid = sectionMap['uuid'] ?? '';
    for (var location in sectionMap['Location']) {
      paths.add(location['path']);
    }
  }


  String title;
  int id;
  String type;
  String uuid;
  List<String> paths = [];

  @override
  bool operator ==(ps) => uuid == ps.uuid;
}
