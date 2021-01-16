enum PlexTypes {
  movie,
  show,
  season,
  episode,
  trailer,
  comic,
  person,
  artist,
  album,
  track,
  clip,
  photo,
  photoAlbum,
  playlist,
  playlistFolder,
  podcast,
}

extension XPlexTypes on PlexTypes {
  static const values = {
    PlexTypes.movie: 1,
    PlexTypes.show: 2,
    PlexTypes.season: 3,
    PlexTypes.episode: 4,
    PlexTypes.trailer: 5,
    PlexTypes.comic: 6,
    PlexTypes.person: 7,
    PlexTypes.artist: 8,
    PlexTypes.album: 9,
    PlexTypes.track: 10,
    PlexTypes.clip: 12,
    PlexTypes.photo: 13,
    PlexTypes.photoAlbum: 14,
    PlexTypes.playlist: 15,
    PlexTypes.playlistFolder: 16,
    PlexTypes.podcast: 17,
  };

  int get value => values[this];
}
