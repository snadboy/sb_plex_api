import 'package:sb_plex_api/src/plex_server.dart';

class PlexSection {
  PlexSection(this.plexServer, Map<String, dynamic> sectionMap) {
    title = sectionMap['title'] ?? '';
    id = sectionMap['key'] ?? '';
    type = sectionMap['type'] ?? '';
    uuid = sectionMap['uuid'] ?? '';
    for (var location in sectionMap['Location']) {
      paths.add(location['path']);
    }
  }

  final PlexServer plexServer;

  String title;
  String id;
  String type;
  String uuid;
  List<String> paths = [];

  static List<PlexSection> parseSections(PlexServer plexServer, List<Map<String, dynamic>> sections) {
    return sections.map((s) => PlexSection(plexServer, s)).toList();
  }

  @override
  bool operator ==(ps) => uuid == ps.uuid;
}
