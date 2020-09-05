import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mymovyapp/controller/movie_controller.dart';
import 'package:mymovyapp/exceptions/fetch_failure.dart';
import 'package:mymovyapp/model/movie_config.dart';
import 'package:mymovyapp/model/movie_list_response.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  MovieController _controller;
  List<Results> results = [];
  MovieConfigResponse response;
  int _pageNo = 0;
  NowPlayingCubit(this._controller) : super(NowPlayingInitial([]));
  int _nextPage() {
    _pageNo = _pageNo + 1;
    return _pageNo;
  }

  void fetchTopMovies() async {
    try {
      emit(NowPlayingInProgress(results));

      var resp = await _controller.fetchPopularMovies(_nextPage());
      if (resp.isSuccessful) {
        response = _controller.configResponse;
        var res = MovieListResponse.fromJson(resp.body);

        results = [...results, ...res.results];
        emit(NowPlayingSuccess(results));
      } else
        throw FetchFailure();
    } catch (ex) {
      print(ex.toString());
      emit(NowPlayingInFailure(results, ex.toString()));
    }
  }
}
