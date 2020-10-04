import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mymovyapp/bloc/index.dart';

class TopRatedComponent extends StatelessWidget {
  final ScrollController _controller;

  const TopRatedComponent(this._controller);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: BlocConsumer<TopRatedCubit, TopRatedState>(
          listener: (context, state) {},
          builder: _buildBody,
        ),
      ),
    );
  }

  Widget _buildBody(context, state) {
    if (state is TopRatedInFailure)
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.message),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                child: Text("Try again"),
                onPressed: () {
                  context.bloc<TopRatedCubit>().fetchTopMovies();
                },
              )
            ],
          ),
        ),
      );

    if (state is TopRatedInSuccess)
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.33,
        child: Column(
          children: [
            ListTile(
              title: Text("Top Rated"),
              subtitle: Text("Highly rated movies"),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 2,
                scrollDirection: Axis.horizontal,
                staggeredTileBuilder: (int index) => new StaggeredTile.count(
                    index % 9 == 0 ? 4 : 2, index % 9 == 0 ? 2 : 1),
                controller: _controller,
                itemCount: state.movieList.length,
                itemBuilder: (context, i) => LayoutBuilder(
                  builder: (context, constraints) => ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(
                      context
                              .bloc<TopRatedCubit>()
                              .response
                              .images
                              .secureBaseUrl +
                          "/w500" +
                          state.movieList[i].posterPath,
                      width: constraints.maxHeight,
                      height: constraints.maxWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
