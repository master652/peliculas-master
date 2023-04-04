import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '053280fb5647a8736b4dea1e85fc2971';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;
  MoviesProvider() {
    print('Movies provider Iniciardor');
    this.getOnDisplayMovies();
    this.getPopularMovie();
  }
  Future<String> _getJasonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJasonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromRawJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovie() async {
    _popularPage++;

    final jsonData = await this._getJasonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromRawJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();
  }
}
