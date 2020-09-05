import 'package:chopper/chopper.dart';
import 'package:mymovyapp/exceptions/config_failure.dart';
import 'package:mymovyapp/model/movie_config.dart';
import 'package:mymovyapp/service/movie_service.dart';

class MovieController {
  final MovieApiService _apiService;
  MovieConfigResponse _configResponse;
  MovieController(this._apiService);
  get configResponse=>_configResponse!=null?_configResponse:throw ConfigFailure();
  Future<Response> fetchTopRatedMovies(int pageNo) async{
    if(_configResponse==null) await _fetchConfigs();
    var resp=await _apiService.getTopRatedMovies(pageNo);

    return resp;
  }

  Future<Response> fetchNowPlayingMovies(int pageNo) async{
    if(_configResponse==null) await _fetchConfigs();
    var resp=await _apiService.getNowPlayingMovies(pageNo);

    return resp;
  }
  Future<Response> fetchPopularMovies(int pageNo) async{
    if(_configResponse==null) await _fetchConfigs();
    var resp=await _apiService.getPopularMovies(pageNo);

    return resp;
  }

  Future<Response> fetchSimilarMoviesByMovieID(int movieId,int pageNo) async{
    if(_configResponse==null) await _fetchConfigs();
    var resp=await _apiService.getSimilarMovies(movieId, pageNo);

    return resp;
  }
  Future<Response> _fetchConfigs() async{

    var resp=await _apiService.getConfigs();
    if(resp.isSuccessful)
     _configResponse=MovieConfigResponse.fromJson(resp.body);
    return resp;
  }

}