import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../search/search_delegate.dart';

class HomeScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    print(moviesProvider.onDisplayMovies);

    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cine'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            //Tarjetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),

            //sliders de peliculas

            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares',
              onNextPage: () => moviesProvider.getPopularMovie(),
            ),
          ]),
        ));
  }
}
