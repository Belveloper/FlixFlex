import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixflex/controllers/Movies/cubit.dart';
import 'package:flixflex/models/movie_model.dart';
import 'package:flixflex/views/movie_details_screen.dart';
import 'package:flutter/material.dart';

Widget movieWidget(
        {double? height,
        required Results? movie,
        required BuildContext context,
        MovieCubit? cubit,
        required int? index,
        required bool? isMovie}) =>
    cubit == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                margin: const EdgeInsets.all(4.0),
                height: height! * 0.19,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        height: height * 0.162,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xFF1a1c20),
                                  Color(0xFF222222),
                                ]),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: height * 0.162 + 16,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      isMovie!
                                          ? cubit.popularMovies!
                                              .results![index!].title
                                              .toString()
                                          : cubit.popularSeries!
                                              .results![index!].name
                                              .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Regular",
                                          fontWeight: FontWeight.w200,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                    Row(
                                      children: [
                                        const Image(
                                            height: 19,
                                            image: NetworkImage(
                                                'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/IMDB_Logo_2016.svg/2560px-IMDB_Logo_2016.svg.png')),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          isMovie
                                              ? '${cubit.popularMovies!.results![index].voteAverage}/10'
                                              : '${cubit.popularSeries!.results![index].voteAverage}/10',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "⭐ ${isMovie ? cubit.popularMovies!.results![index].voteAverage.toString() : cubit.popularSeries!.results![index].voteAverage.toString()}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w200,
                                              fontFamily: "Poppins-Regular",
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.033),
                                        ),
                                        SizedBox(
                                          child: Text(
                                            "  |  ",
                                            style: TextStyle(
                                                color: Colors.white24,
                                                fontWeight: FontWeight.w100,
                                                fontFamily: "Poppins-Light",
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              isMovie ? '' : 'Language: ',
                                              style: TextStyle(
                                                  color: Colors.white24,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins-Light",
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03),
                                            ),
                                            Text(
                                              isMovie
                                                  ? cubit
                                                      .popularMovies!
                                                      .results![index]
                                                      .releaseDate
                                                      .toString()
                                                  : cubit
                                                      .popularSeries!
                                                      .results![index]
                                                      .originalLanguage
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w200,
                                                  fontFamily: "Poppins-Regular",
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.033),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 0,
                      height: height * 0.19,
                      width: height * 0.16,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => MovieDetailsScreen(
                                    isMovie: isMovie,
                                    index: movie!.id!,
                                    movie: isMovie
                                        ? cubit.popularMovies!.results![index]
                                        : cubit.popularSeries!.results![index],
                                  )));
                        },
                        child: Hero(
                          tag:
                              "https://image.tmdb.org/t/p/original${isMovie ? cubit.popularMovies!.results![index].posterPath.toString() : cubit.popularSeries!.results![index].posterPath.toString()}",
                          child: Container(
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                                color: const Color(0xFF333333),
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: false
                                  ? Image.network(
                                      'https://image.tmdb.org/t/p/original${cubit.popularMovies!.results![index].posterPath.toString()}',
                                      width: 145,
                                      fit: BoxFit.cover)
                                  : CachedNetworkImage(
                                      width: 145,
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/original${isMovie ? cubit.popularMovies!.results![index].posterPath.toString() : cubit.popularSeries!.results![index].posterPath.toString()}",
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
