import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovyapp/bloc/index.dart';
import 'package:mymovyapp/components/now_playing_component.dart';
import 'package:mymovyapp/components/popular_component.dart';
import 'package:mymovyapp/components/toprated_component.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ScrollController _controllerTopRated;
  ScrollController _controllerPopular;
  ScrollController _controllerNowPlaying;

  @override
  void initState() {
    _controllerTopRated = ScrollController();
    _controllerPopular = ScrollController();
    _controllerNowPlaying = ScrollController();
    super.initState();

    _controllerTopRated.addListener(() {
      if (_controllerTopRated
          .position.atEdge) if (_controllerTopRated.position.pixels != 0)
        context.bloc<TopRatedCubit>().fetchTopMovies();
    });

    _controllerPopular.addListener(() {
      if (_controllerPopular
          .position.atEdge) if (_controllerPopular.position.pixels != 0)
        context.bloc<PopularCubit>().fetchTopMovies();
    });

    _controllerNowPlaying.addListener(() {
      if (_controllerNowPlaying
          .position.atEdge) if (_controllerNowPlaying.position.pixels != 0)
        context.bloc<NowPlayingCubit>().fetchTopMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(Icons.headset_mic),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 12,
              ),
              _featured(),
              _buildNewBody(),
              _buildPopularBody(),
              _buildTopRatedBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featured() {
    Widget _generateFeatureRow(
        FeaturedState state, BoxConstraints constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Image.network(
                context.bloc<FeaturedCubit>().response.images.secureBaseUrl +
                    "/w500" +
                    state.movie.posterPath,
                width: constraints.maxWidth * 0.45,
                height: constraints.maxHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(state.movie.title),
                subtitle: Text(state.movie.overview),
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.43,
      padding: EdgeInsets.all(8.0),
      child: BlocConsumer<FeaturedCubit, FeaturedState>(
        builder: (context, state) => Container(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (state is FeaturedInProgress) if (state.movie == null)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else
                return _generateFeatureRow(state, constraints);

              return _generateFeatureRow(state, constraints);
            },
          ),
        ),
        listener: (context, state) {},
      ),
    );
  }

  Widget _buildTopRatedBody() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.33,
        child: TopRatedComponent(_controllerTopRated));
  }

  Widget _buildPopularBody() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.33,
        child: PopularComponent(_controllerPopular));
  }

  Widget _buildNewBody() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.33,
        child: NowPlayingComponent(_controllerNowPlaying));
  }
}
