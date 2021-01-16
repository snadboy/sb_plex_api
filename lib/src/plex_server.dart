import 'dart:convert';
import 'dart:io';

import 'package:image/image.dart' as image;
import 'package:sb_extensions/sb_extensions.dart';

import 'package:sb_plex_api/sb_plex_api.dart';

typedef LoadProgress = void Function(String progress);

class PlexServer {
  factory PlexServer(String server, int port, String xPlexToken) {
    return _instances.firstWhere((i) => i.plexServer == server && i.plexPort == port, orElse: () {
      final p = PlexServer._internal(server, port, xPlexToken);
      _instances.add(p);
      return _instances.last;
    });
  }

  PlexServer._internal(this.plexServer, this.plexPort, this.xPlexToken);

  static final List<PlexServer> _instances = [];
  final String plexServer;
  final int plexPort;
  final String xPlexToken;
  final _sections = <PlexSection>[];
  final _shows = <PlexShow>[];
  final _movies = <PlexMovie>[];

  Future<void> loadData({LoadProgress loadProgress}) async {
    if (loadProgress != null) loadProgress('Plex data loading');

    // Load sections from Plex Server
    if (loadProgress != null) loadProgress('... sections');

    _sections.clear();

    var libSections = await fetchPlexJson('/library/sections');
    List dirs = libSections.path('MediaContainer.Directory') ?? [];
    dirs.forEach((d) => _sections.add(PlexSection(this, d)));

    // Load shows from Plex Server
    if (loadProgress != null) loadProgress('... shows');

    _shows.clear();

    final libShows = await fetchPlexJson('/library/all?type=${PlexTypes.show.value}');
    final metaShows = libShows.path('MediaContainer.Metadata') as List<dynamic>;
    metaShows.forEach((m) {
      var existingShow = _shows.firstWhere((sh) => sh.uuid == m['guid'], orElse: () => null);
      if (existingShow == null) {
        _shows.add(PlexShow(this, m));
      } else {
        existingShow.sectionIds.add(m['librarySectionID'].toString());
      }
    });

    // Load movies from Plex Server
    if (loadProgress != null) loadProgress('... movies');

    _movies.clear();

    final libMovies = await fetchPlexJson('/library/all?type=${PlexTypes.movie.value}');
    final metaMovies = libMovies.path('MediaContainer.Metadata') as List<dynamic>;
    metaMovies.forEach((m) {
      var existingMovie = _movies.firstWhere((sh) => sh.uuid == m['guid'], orElse: () => null);
      if (existingMovie == null) {
        _movies.add(PlexMovie(this, m));
      } else {
        existingMovie.sectionIds.add(m['librarySectionID'].toString());
      }
    });

    if (loadProgress != null) loadProgress('Plex data loaded');
  }

  String plexUrl(String path) => 'http://$plexServer:$plexPort$path';
  Map<String, String> get xPlexTokenHdr => {'X-PLEX-TOKEN': xPlexToken};

  Future<HttpClientResponse> fetchPlex(String path) async {
    final hc = HttpClient();
    final hcrq = await hc.getUrl(Uri.parse(plexUrl(path)));
    hcrq.headers.add('X-PLEX-TOKEN', xPlexToken);
    hcrq.headers.add('Accept', 'application/json');
    hcrq.headers.add('Accept-Encoding', 'gzip,deflate,br');
    return await hcrq.close();
  }

  Future<Map<String, dynamic>> fetchPlexJson(String path) async {
    final hcrs = await fetchPlex(path);
    if (hcrs.statusCode != 200) {
      throw Exception('HTTP request returned status code of ${hcrs.statusCode} - ${hcrs.reasonPhrase}');
    } else if (hcrs.headers.contentType.value != 'application/json') {
      throw Exception('HTTP request did not return JSON content.  It returned ${hcrs.headers.contentType.value}');
    } else {
      return await hcrs.transform(utf8.decoder).transform(json.decoder).last; //.first;
    }
  }

  Future<image.Image> fetchPlexImage(String path) async {
    final hcrs = await fetchPlex(path);

    if (hcrs.statusCode != 200) {
      throw Exception('HTTP request returned status code of ${hcrs.statusCode} - ${hcrs.reasonPhrase}');
    } else if (hcrs.headers.contentType.primaryType != 'image') {
      throw Exception('HTTP request did not return image content.  It returned ${hcrs.headers.contentType.value}');
    } else {
      final bytes = [for (var sublist in await hcrs.toList()) ...sublist];
      return image.decodeImage(bytes);
    }
  }

  List<PlexShow> get shows => _shows;
  List<PlexSection> get sections => _sections;
  List<PlexMovie> get movies => _movies;

  PlexSection sectionById(String id) => _sections.firstWhere((s) => s.id == id, orElse: () => null);
}
