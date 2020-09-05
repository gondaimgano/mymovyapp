part of 'popular_cubit.dart';

abstract class PopularState extends Equatable {
  final List<Results> movieList;
  const PopularState(this.movieList);
  @override
  List<Object> get props => [];
}

class PopularInitital extends PopularState {
  PopularInitital(List<Results> movieList) : super(movieList);
}

class PopularInProgress extends PopularState {
  PopularInProgress(List<Results> movieList) : super(movieList);
}

class PopularInSuccess extends PopularState {
  PopularInSuccess(List<Results> movieList) : super(movieList);
}

class PopularInFailure extends PopularState {
  final String message;
  PopularInFailure(List<Results> movieList, [this.message]) : super(movieList);
}
