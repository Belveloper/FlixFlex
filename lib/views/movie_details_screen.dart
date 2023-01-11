import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixflex/controllers/Movies/cubit.dart';
import 'package:flixflex/controllers/Movies/states.dart';
import 'package:flixflex/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatefulWidget {
  bool isMovie = true;
  int? index;
  Results movie;

  MovieDetailsScreen({
    required this.isMovie,
    required this.index,
    required this.movie,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.isMovie) {
      context.read<MovieCubit>().getMovieDetails(id: widget.index!);
      context.read<MovieCubit>().getMovieTrailer(
            id: widget.movie.id!,
            movieOrTv: 'movie',
          );
    } else {
      context.read<MovieCubit>().getSerieDetails(id: widget.index!);
      context.read<MovieCubit>().getMovieTrailer(
            id: widget.movie.id!,
            movieOrTv: 'tv',
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit, MovieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MovieCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Hero(
                    tag:
                        "https://image.tmdb.org/t/p/original${widget.movie.posterPath.toString()}",
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.57,
                      color: const Color(0xFF333333),
                      child: false
                          ? Image.network(
                              "https://image.tmdb.org/t/p/original${widget.movie.posterPath.toString()}",
                              width: double.infinity,
                              fit: BoxFit.cover)
                          : CachedNetworkImage(
                              width: double.infinity,
                              imageUrl:
                                  "https://image.tmdb.org/t/p/original${widget.movie.posterPath.toString()}",
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.57,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              const Color(0xFF000000).withOpacity(1),
                              Colors.transparent,
                            ],
                            stops: const [
                              0.2,
                              0.4,
                            ]),
                      )),
                  Positioned(
                    top: 30,
                    left: 16,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 16),
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white24),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      widget.isMovie
                          ? widget.movie.title.toString()
                          : widget.movie.name.toString(),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.07,
                          fontFamily: "Poppins-Bold",
                          color: const Color(0xFFFBFBFB) //Color(0xFF5d59d8)
                          ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text("Storyline",
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 118, 132, 255),
                                      fontFamily: "Poppins-Regular",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05)),
                            ),
                            Text(widget.movie.overview.toString(),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontFamily: "Poppins-Regular",
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.038)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 5),
                              child: Text("Score on IMdb",
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 118, 132, 255),
                                      fontFamily: "Poppins-Regular",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05)),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${widget.movie.voteAverage}/10',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "Poppins-Regular",
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Image(
                                  height: 25,
                                  image: NetworkImage(
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/IMDB_Logo_2016.svg/2560px-IMDB_Logo_2016.svg.png'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Trailer",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 118, 132, 255),
                                  fontFamily: "Poppins-Regular",
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Watch trailer',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins-Regular",
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if (cubit.videoKey != null) {
                                      await launchUrl(Uri.parse(
                                          "https://www.youtube.com/watch?v=${cubit.videoKey}"));
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.play_circle,
                                    size: 30,
                                    color: Color.fromARGB(255, 118, 132, 255),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
