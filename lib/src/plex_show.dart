import 'package:sb_plex_api/src/plex_server.dart';

class PlexShow {
  PlexShow(this.plexServer, Map<String, dynamic> showMap) {
    title = showMap['title'] ?? '';
    key = showMap['key'] ?? '';
    sectionIds.add(showMap['librarySectionID'].toString() ?? '');
    uuid = showMap['guid'] ?? '';
    thumbKey = showMap['thumb'] ?? '';
    artKey = showMap['art'] ?? '';
    bannerKey = showMap['banner'] ?? '';
    themeKey = showMap['theme'] ?? '';
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
  String bannerKey;
  String themeKey;
  DateTime addedAt;
  DateTime updatedAt;

  static List<PlexShow> parseShows(PlexServer plexServer, List<Map<String, dynamic>> shows) {
    return shows.map((s) => PlexShow(plexServer, s)).toList();
  }

  @override
  bool operator ==(ps) => uuid == ps.uuid;
}
