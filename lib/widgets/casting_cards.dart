import 'package:flutter/cupertino.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../models/credits_response.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId);
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastCards(cast[index]),
          ),
        );
      },
    );
  }
}

class _CastCards extends StatelessWidget {
  final Cast actor;

  const _CastCards(this.actor);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/noimg.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
