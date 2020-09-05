part of 'now_playing_cubit.dart';

abstract class NowPlayingState extends Equatable {
  final List<Results> movieList;
  const NowPlayingState(this.movieList);
  @override
  List<Object> get props => [];
}

class NowPlayingInitial extends NowPlayingState {
  NowPlayingInitial(List<Results> movieList) : super(movieList);
}

class NowPlayingInProgress extends NowPlayingState {
  NowPlayingInProgress(List<Results> movieList) : super(movieList);
}

class NowPlayingSuccess extends NowPlayingState {
  NowPlayingSuccess(List<Results> movieList) : super(movieList);
}

class NowPlayingInFailure extends NowPlayingState {
  final String message;
  NowPlayingInFailure(List<Results> movieList, [this.message])
      : super(movieList);
}
