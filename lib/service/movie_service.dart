import 'package:chopper/chopper.dart';

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'movie_service.chopper.dart';

@ChopperApi(baseUrl: '/3')
abstract class MovieApiService extends ChopperService {
  @Get(path: '/movie/top_rated')
  Future<Response> getTopRatedMovies(@Query() int page);

  @Get(path: '/movie/popular')
  Future<Response> getPopularMovies(@Query() int page);

  @Get(path: '/movie/now_playing')
  Future<Response> getNowPlayingMovies(@Query() int page);

  @Get(path: '/movie/{movieId}/similar')
  Future<Response> getSimilarMovies(@Path() int movieId, @Query() int page);

  @Get(path: '/configuration')
  Future<Response> getConfigs();

  static MovieApiService create() {
    final client = ChopperClient(
        // The first part of the URL is now here E.G https://jsonplaceholder.typicode.com
        baseUrl: 'https://api.themoviedb.org',
        services: [
          // The generated implementation
          _$MovieApiService(),
        ],
        interceptors: [HttpLoggingInterceptor(), _addQuery],
        // Converts data to & from JSON and adds the application/json header.
        converter: JsonConverter(),
        errorConverter: JsonConverter());

    // The generated class with the ChopperClient passed in
    return _$MovieApiService(client);
  }

  static Request _addQuery(Request req) {
    final params = Map<String, dynamic>.from(req.parameters);
    // TODO (ADD YOUR API KEY HERE)
    params['api_key'] = '';
    params['language'] = 'en-US';

    return req.copyWith(parameters: params);
  }
}
