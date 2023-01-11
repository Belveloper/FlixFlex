import 'package:flixflex/controllers/Movies/cubit.dart';
import 'package:flixflex/controllers/Movies/states.dart';
import 'package:flixflex/views/Components/components.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  MovieCubit cubit;

  MovieStates state;
  bool isMovie;

  MovieList(this.cubit, this.state, [this.isMovie = true]);

  @override
  Widget build(BuildContext context) {
    return cubit.popularMovies == null ||
            cubit.popularSeries == null ||
            state is GetMoviesLoadingState ||
            state is GetSeriesLoadingState
        ? const Center(
            child: CircularProgressIndicator(color: Colors.white),
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cubit.length,
                  itemBuilder: (ctx, index) {
                    final movie = isMovie
                        ? cubit.popularMovies!.results![index]
                        : cubit.popularSeries!.results![index];

                    return MovieWidget(
                      context: context,
                      movie: movie,
                      isMovie: true,
                      cubit: cubit,
                    );
                  },
                  separatorBuilder: (ctx, index) => const SizedBox(height: 10),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    int length = isMovie
                        ? cubit.popularMovies!.results!.length
                        : cubit.popularSeries!.results!.length;
                    cubit.setLength(length);
                  },
                  child: cubit.length == 10
                      ? Container(
                          height: 40,
                          width: 150,
                          color: Colors.white,
                          child: const Text(
                            'view all',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (cubit.length > 10)
                              GestureDetector(
                                onTap: () async {
                                  int? page = isMovie
                                      ? cubit.popularMovies!.page
                                      : cubit.popularSeries!.page;
                                  if (page == 1) {
                                    cubit.setLength(10);
                                  } else {
                                    isMovie
                                        ? await cubit.getMovies(page: page! - 1)
                                        : await cubit.getSeries(
                                            page: page! - 1);
                                  }
                                },
                                child: Text(
                                  'previous',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.purple.shade200),
                                ),
                              ),
                            Text(
                              '${isMovie ? cubit.popularMovies!.page : cubit.popularSeries!.page}/${isMovie ? cubit.popularMovies!.page : cubit.popularSeries!.totalPages}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            GestureDetector(
                              onTap: () async {
                                isMovie
                                    ? await cubit.getMovies(
                                        page: cubit.popularMovies!.page! + 1)
                                    : await cubit.getSeries(
                                        page: cubit.popularSeries!.page! + 1);
                              },
                              child: Text(
                                ' next',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.purple.shade200),
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
  }
}
