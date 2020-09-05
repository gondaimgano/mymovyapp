import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mymovyapp/controller/movie_controller.dart';
import 'package:mymovyapp/model/movie_config.dart';
import 'package:mymovyapp/model/movie_list_response.dart';

part 'featured_state.dart';

class FeaturedCubit extends Cubit<FeaturedState> {
  Results _results;
  final MovieController _controller;

  MovieConfigResponse response;
  FeaturedCubit(this._controller) : super(FeaturedInProgress(null));

  void fetchFeatured(Results results) {
    try {
      emit(FeaturedInProgress(null));
      response = _controller.configResponse;
      _results = results;
      emit(FeaturedSuccess(_results));
    } catch (ex) {
      emit(FeaturedInFailure(results, ex.toString()));
    }
  }
}
