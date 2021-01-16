import 'package:sb_plex_api/sb_plex_api.dart';

Future<void> main() async {
  final pl = PlexServer(
    'bee-plex',
    32400,
    'qzhfmzSEHu_Sykd8bSH9',
  );
  await pl.loadData(loadProgress: (s) => print(s));
  print('Plex data loaded');
  print('');

  pl.sections.forEach((s) => print('Section: ${s.title}[${s.id}] -=- paths: ${s.paths.join(', ')}'));
  pl.shows.forEach((s) => print('Show: ${s.title} -=- ${s.sectionIds.map((c) => pl.sectionById(c).title).toList().join(', ')}'));
  pl.movies.forEach((m) => print('Movie: ${m.title} -=- ${m.sectionIds.map((c) => pl.sectionById(c).title).toList().join(', ')}'));
}
