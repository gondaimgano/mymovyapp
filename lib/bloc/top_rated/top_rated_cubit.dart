import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mymovyapp/controller/movie_controller.dart';
import 'package:mymovyapp/exceptions/fetch_failure.dart';
import 'package:mymovyapp/model/movie_config.dart';
import 'package:mymovyapp/model/movie_list_response.dart';

part 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  MovieController _controller;
  List<Results> results = [];
  MovieConfigResponse response;
  int _pageNo = 0;
  TopRatedCubit(this._controller) : super(TopRatedInitial([]));
  int _nextPage() {
    _pageNo = _pageNo + 1;
    return _pageNo;
  }

  void fetchTopMovies() async {
    try {
      emit(TopRatedInProgress(results));

      var resp = await _controller.fetchTopRatedMovies(_nextPage());
      if (resp.isSuccessful) {
        response = _controller.configResponse;
        var res = MovieListResponse.fromJson(resp.body);
        print(res.results.last.title);
        results = [...results, ...res.results];
        emit(TopRatedInSuccess(results));
      } else
        throw FetchFailure();
    } catch (ex) {
      print(ex.toString());
      emit(TopRatedInFailure(results, ex.toString()));
    }
  }
}
