import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mymovyapp/controller/movie_controller.dart';
import 'package:mymovyapp/exceptions/fetch_failure.dart';
import 'package:mymovyapp/model/movie_config.dart';
import 'package:mymovyapp/model/movie_list_response.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  MovieController _controller;
  List<Results> results = [];
  MovieConfigResponse response;
  int _pageNo = 0;
  PopularCubit(this._controller) : super(PopularInitital([]));
  int _nextPage() {
    _pageNo = _pageNo + 1;
    return _pageNo;
  }

  void fetchTopMovies() async {
    try {
      emit(PopularInProgress(results));

      var resp = await _controller.fetchPopularMovies(_nextPage());
      if (resp.isSuccessful) {
        response = _controller.configResponse;
        var res = MovieListResponse.fromJson(resp.body);

        results = [...results, ...res.results];
        emit(PopularInSuccess(results));
      } else
        throw FetchFailure();
    } catch (ex) {
      print(ex.toString());
      emit(PopularInFailure(results, ex.toString()));
    }
  }
}
