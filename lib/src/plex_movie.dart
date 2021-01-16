import 'package:sb_plex_api/src/plex_server.dart';

class PlexMovie {
  PlexMovie(this.plexServer, Map<String, dynamic> showMap) {
    title = showMap['title'] ?? '';
    key = showMap['key'] ?? '';
    sectionIds.add(showMap['librarySectionID'].toString() ?? '');
    uuid = showMap['guid'] ?? '';
    thumbKey = showMap['thumb'] ?? '';
    artKey = showMap['art'] ?? '';
    addedAt = DateTime.fromMillisecondsSinceEpoch((showMap['addedAt'] ?? 0) * 1000);
    updatedAt = DateTime.fromMillisecondsSinceEpoch((showMap['updatedAt'] ?? 0) * 1000);
  }

  final PlexServer plexServer;

  String title;
  String key;
  String uuid;
  var sectionIds = <String>[];
  String thumbKey;
  String artKey;
  DateTime addedAt;
  DateTime updatedAt;

  static List<PlexMovie> parseShows(PlexServer plexServer, List<Map<String, dynamic>> movies) {
    return movies.map((s) => PlexMovie(plexServer, s)).toList();
  }

  @override
  bool operator ==(pm) => uuid == pm.uuid;
}
