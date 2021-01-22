import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image/image.dart' as image;

import '../../sb_plex_api.dart';

class PlexFetch {
  PlexFetch(this.plexServer);

  final PlexServer plexServer;

  Future<http.Response> fetchPlex(String path, {String acceptMimeType}) async {
    return http.get(plexServer.plexUrl(path), headers: {
      'X-PLEX-TOKEN': plexServer.xPlexToken,
      'Accept': '${acceptMimeType ?? '*/*'}',
      'Accept-Encoding': 'gzip,deflate,br',
    });
  }

  Future<Map<String, dynamic>> fetchPlexJson(String path) async {
    final response = await fetchPlex(path, acceptMimeType: 'application/json');
    return response.statusCode != 200
        ? throw Exception('HTTP request returned status code of ${response.statusCode} - ${response.reasonPhrase}')
        : jsonDecode(response.body);
  }

  Future<image.Image> fetchPlexImage(String path) async {
    final response = await fetchPlex(path, acceptMimeType: 'image/*');
    return response.statusCode != 200
        ? throw Exception('HTTP request returned status code of ${response.statusCode} - ${response.reasonPhrase}')
        : image.decodeImage(response.bodyBytes);
  }
}
