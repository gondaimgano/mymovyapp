import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:mymovyapp/bloc/index.dart';
import 'package:mymovyapp/controller/movie_controller.dart';
import 'package:mymovyapp/screen/dashboard_page.dart';
import 'package:mymovyapp/service/movie_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  runApp(Repos());
}

class Repos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => MovieController(MovieApiService.create()),
        )
      ],
      child: Root(),
    );
  }
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TopRatedCubit(context.repository<MovieController>())
            ..fetchTopMovies(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => PopularCubit(context.repository<MovieController>())
            ..fetchTopMovies(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => NowPlayingCubit(context.repository<MovieController>())
            ..fetchTopMovies(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => FeaturedCubit(context.repository<MovieController>()),
          lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: DashboardPage(),
    );
  }
}
