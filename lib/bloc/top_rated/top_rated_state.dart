part of 'top_rated_cubit.dart';

abstract class TopRatedState extends Equatable {
  final List<Results> movieList;
  const TopRatedState(this.movieList);
  @override
  List<Object> get props => [];
}

class TopRatedInitial extends TopRatedState {


  TopRatedInitial(List<Results> movieList):super(movieList);

}
class TopRatedInProgress extends TopRatedState {


  TopRatedInProgress(List<Results> movieList):super(movieList);
}
class TopRatedInSuccess extends TopRatedState {


  TopRatedInSuccess(List<Results> movieList):super(movieList);

}

class TopRatedInFailure extends TopRatedState {

  final String message;
  TopRatedInFailure(List<Results> movieList,[this.message]):super(movieList);


}
