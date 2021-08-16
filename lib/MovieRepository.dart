import 'package:flutter_bloc/ApiBaseHelper.dart';
import 'package:flutter_bloc/MovieResponse.dart';

class MovieRepository {
  final String _apiKey = "4752cd17517d23913284ff7c2a02c981";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Movie>> fetchMovieList() async {
    final response = await _helper.get("movie/popular?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }
}