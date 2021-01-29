import 'package:sb_plex_api/sb_plex_api.dart';
import 'package:sb_dart_extensions/sb_dart_extensions.dart';

class PlexServer {
  PlexServer(this.plexServerUrl, this.plexPort, this.xPlexToken) {
    plexFetch = PlexFetch(this);
  }

  PlexFetch plexFetch;
  final String plexServerUrl;
  final int plexPort;
  final String xPlexToken;
  final String xPlexTokenHdr = 'X-PLEX-TOKEN';
  final _sections = <PlexSection>[];
  final _shows = <PlexShow>[];
  final _movies = <PlexMovie>[];

  List<PlexShow> get shows => _shows;
  PlexShowSequence _showSequence = PlexShowSequence.Title;
  bool _showSequenceAscending = true;
  void sortShows(PlexShowSequence sequence, bool ascending) {
    if (sequence != _showSequence || ascending != _showSequenceAscending) {
      _showSequenceAscending = ascending;
      _showSequence = sequence;

      switch (sequence) {
        case PlexShowSequence.Title:
          _shows.sort((ps1, ps2) => ps1.titleSort.compareTo(ps2.titleSort) * (ascending ? 1 : -1));
          break;
        case PlexShowSequence.Added:
          _shows.sort((ps1, ps2) => ps1.addedAt.compareTo(ps2.addedAt) * (ascending ? 1 : -1));
          break;
        case PlexShowSequence.Updated:
          _shows.sort((ps1, ps2) => ps1.updatedAt.compareTo(ps2.updatedAt) * (ascending ? 1 : -1));
          break;
        case PlexShowSequence.OriginallyAvailable:
          _shows.sort((ps1, ps2) => ps1.originallyAt.compareTo(ps2.originallyAt) * (ascending ? 1 : -1));
          break;
      }

      
    }
  }

  List<PlexSection> get sections => _sections;
  List<PlexMovie> get movies => _movies;

  String plexUrl(String path) => 'http://$plexServerUrl:$plexPort$path';

  Future<void> loadData() async {
    // Reload the 'sections'
    _sections.clear();
    var libSections = await plexFetch.fetchPlexJson('/library/sections');
    List dirs = libSections.path('MediaContainer.Directory') ?? [];
    dirs.forEach((d) => _sections.add(PlexSection(d)));

    // Reload the 'shows'
    _shows.clear();
    final libShows = await plexFetch.fetchPlexJson('/library/all?type=${PlexTypes.show.value}');
    final metaShows = libShows.path('MediaContainer.Metadata') as List<dynamic>;
    metaShows.forEach((m) {
      var existingShow = _shows.firstWhere((sh) => sh.uuid == m['guid'], orElse: () => null);
      existingShow == null ? _shows.add(PlexShow(m)) : existingShow.sectionIds.add(m['librarySectionID']);
    });

    // Reload the 'movies'
    _movies.clear();
    final libMovies = await plexFetch.fetchPlexJson('/library/all?type=${PlexTypes.movie.value}');
    final metaMovies = libMovies.path('MediaContainer.Metadata') as List<dynamic>;
    metaMovies.forEach((m) {
      var existingMovie = _movies.firstWhere((sh) => sh.uuid == m['guid'], orElse: () => null);
      existingMovie == null ? _movies.add(PlexMovie(m)) : existingMovie.sectionIds.add(m['librarySectionID']);
    });
  }

  PlexSection sectionById(int id) => _sections.firstWhere((s) => s.id == id, orElse: () => null);
}
