import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '053280fb5647a8736b4dea1e85fc2971';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  List<Movie> onDisplayMovies = [];
  MoviesProvider() {
    print('Movies provider Iniciardor');
    this.getOnDisplayMovies();
  }
  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }
}
