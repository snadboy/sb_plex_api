import 'package:sb_plex_api/src/models/plex_media_item.dart';

enum PlexMovieSequence {
  Title,
  Added,
  Updated,
  OriginallyAvailable,
}

class PlexMovie extends PlexMediaItem {
  PlexMovie(Map<String, dynamic> movieMap)
      : super(
            key: movieMap['key'] ?? '',
            title: movieMap['title'] ?? '',
            titleSort: movieMap['titleSort'] ?? movieMap['title'] ?? '',
            sectionIds: [movieMap['librarySectionID'] ?? -1],
            uuid: movieMap['guid'] ?? '',
            thumbKey: movieMap['thumb'] ?? '',
            artKey: movieMap['art'] ?? '',
            addedAt: DateTime.fromMillisecondsSinceEpoch((movieMap['addedAt'] ?? 0) * 1000),
            updatedAt: DateTime.fromMillisecondsSinceEpoch((movieMap['updatedAt'] ?? 0) * 1000),
            originallyAt: DateTime.tryParse(movieMap['originallyAvailableAt'] ?? ''),
            );
}
