part of 'featured_cubit.dart';

abstract class FeaturedState extends Equatable {
  final Results movie;
  const FeaturedState(this.movie);
  @override
  List<Object> get props => [movie];
}

class FeaturedInitial extends FeaturedState {
  FeaturedInitial(Results movieList) : super(movieList);
}

class FeaturedInProgress extends FeaturedState {
  FeaturedInProgress(Results movieList) : super(movieList);
}

class FeaturedSuccess extends FeaturedState {
  FeaturedSuccess(Results movieList) : super(movieList);
}

class FeaturedInFailure extends FeaturedState {
  final String message;
  FeaturedInFailure(Results movieList, [this.message]) : super(movieList);
}
