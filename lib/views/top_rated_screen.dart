import 'package:flixflex/controllers/Movies/cubit.dart';
import 'package:flixflex/controllers/Movies/states.dart';
import 'package:flixflex/views/Components/components.dart';
import 'package:flutter/material.dart';

class TopRated extends StatelessWidget {
  MovieCubit cubit;
  MovieStates state;

  TopRated(this.cubit, this.state);

  @override
  Widget build(BuildContext context) {
    return cubit.top5Movies == null ||
            cubit.top5Series == null ||
            state is GetTop5MoviesLoadingState ||
            state is GetTop5SeriesLoadingState
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Movies',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins-Bold'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      return MovieWidgetTop(
                        context: context,
                        movie: cubit.top5Movies!.results![index],
                        isMovie: true,
                        cubit: cubit,
                      );
                    },
                    separatorBuilder: (ctx, index) => const SizedBox(width: 10),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Series',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold',
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      return MovieWidgetTop(
                        context: context,
                        movie: cubit.top5Series!.results![index],
                        isMovie: false,
                        cubit: cubit,
                      );
                    },
                    separatorBuilder: (ctx, index) => const SizedBox(width: 10),
                  ),
                ),
              ],
            ),
          );
  }
}
