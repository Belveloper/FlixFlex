import 'package:flixflex/controllers/Movies/cubit.dart';
import 'package:flixflex/controllers/Movies/states.dart';
import 'package:flixflex/views/Widgets/movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesScreen extends StatelessWidget {
  const SeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit, MovieStates>(
      listener: (context, state) {
        if (state is ToggleTabState) {
          print('cubit is woorking fine');
        }
      },
      builder: (ctx, state) {
        return SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height * .81,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemCount: MovieCubit.get(context).popularSeries!.results!.length,
            itemBuilder: (cx, index) => movieWidget(
                movie: MovieCubit.get(context).popularSeries!.results![index],
                cubit: MovieCubit.get(ctx),
                context: context,
                isMovie: false,
                index: index,
                height: MediaQuery.of(context).size.height),
          ),
        ));
      },
    );
  }
}
