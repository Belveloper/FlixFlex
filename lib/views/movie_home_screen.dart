import 'package:flixflex/controllers/Movies/cubit.dart';
import 'package:flixflex/controllers/Movies/states.dart';
import 'package:flixflex/views/Components/components.dart';
import 'package:flixflex/views/Widgets/movie_widget.dart';
import 'package:flixflex/views/series_screen.dart';
import 'package:flixflex/views/top_rated_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<MovieCubit, MovieStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MovieCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: <Widget>[
                  Text(
                    "Flix",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 118, 132, 255),
                        fontSize: width * 0.08,
                        fontFamily: "Poppins-Bold",
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Flex",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.08,
                        fontFamily: "Poppins-Bold",
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ".",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 118, 132, 255),
                      fontSize: width * 0.08,
                      fontFamily: "Poppins-Bold",
                    ),
                  ),
                ],
              ),
              elevation: 0,
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.black,
            body: cubit.popularMovies == null || state is GetMoviesLoadingState
                ? loading()
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TabWidget(
                              title: 'Movies',
                              index: 0,
                              cubit: cubit,
                              context: context),
                          TabWidget(
                              title: 'Top 5 Rated',
                              index: 1,
                              cubit: cubit,
                              context: context),
                          TabWidget(
                              title: 'Series',
                              index: 2,
                              cubit: cubit,
                              context: context),
                        ],
                      ),
                      cubit.tabIndex == 0
                          ? movieList(cubit, height, state, cubit.tabIndex == 1)
                          : cubit.tabIndex == 1
                              ? TopRated(cubit, state)
                              : const SeriesScreen()
                    ],
                  ),
          );
        });
  }
}

class movieList extends StatelessWidget {
  MovieCubit? cubit;

  MovieStates? state;
  bool? isMovie;
  double? height;
  movieList(this.cubit, this.height, this.state, [this.isMovie = true]);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit!.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return SafeArea(
                      child: movieWidget(
                          movie: isMovie!
                              ? MovieCubit.get(context)
                                  .popularMovies!
                                  .results![index]
                              : MovieCubit.get(context)
                                  .popularSeries!
                                  .results![index],
                          height: height,
                          context: context,
                          cubit: cubit,
                          isMovie: true,
                          index: index));
                }),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 36,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: TextButton(
                      onPressed: () {
                        int length = isMovie!
                            ? cubit!.popularMovies!.results!.length
                            : cubit!.popularSeries!.results!.length;
                        cubit!.setLength(length);
                      },
                      child: cubit!.length == 10
                          ? const Text(
                              'View All',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    if (cubit!.length > 10)
                                      InkWell(
                                        onTap: () async {
                                          int? page = isMovie!
                                              ? cubit!.popularMovies!.page
                                              : cubit!.popularSeries!.page;
                                          if (page == 1) {
                                            cubit!.setLength(10);
                                          } else {
                                            isMovie!
                                                ? await cubit!
                                                    .getMovies(page: page! - 1)
                                                : await cubit!
                                                    .getSeries(page: page! - 1);
                                          }
                                        },
                                        child: const Text(
                                          'previous',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    const SizedBox(
                                      width: 70,
                                    ),
                                    Text(
                                      '${isMovie! ? cubit!.popularMovies!.page : cubit!.popularSeries!.page}/${isMovie! ? cubit!.popularMovies!.totalPages! % 3000 : cubit!.popularSeries!.totalPages}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 70,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        isMovie!
                                            ? await cubit!.getMovies(
                                                page: cubit!
                                                        .popularMovies!.page! +
                                                    1)
                                            : await cubit!.getSeries(
                                                page: cubit!
                                                        .popularSeries!.page! +
                                                    1);
                                      },
                                      child: const Text(
                                        '    next',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
