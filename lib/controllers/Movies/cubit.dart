import 'package:flixflex/controllers/Movies/states.dart';
import 'package:flixflex/models/movie_details.dart';
import 'package:flixflex/models/movie_model.dart';
import 'package:flixflex/models/video_model.dart';
import 'package:flixflex/webServices/FlixFlexAPI/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(MovieInitState());
  static MovieCubit get(context) => BlocProvider.of(context);

  int length = 10;
  int tabIndex = 0;
  MovieModel? top5Movies;
  MovieModel? popularMovies;
  MovieModel? top5Series;
  MovieModel? popularSeries;
  MovieDetails? movieDetails;
  MovieDetails? serieDetails;

  void setTabIndex(int index) {
    tabIndex = index;
    emit(ToggleTabState());
  }

  Future getTop5Movies() async {
    emit(GetTop5MoviesLoadingState());
    DioHelper.getData(endPoint: '/movie/top_rated').then((value) {
      print(value);
      top5Movies = MovieModel.fromJson(value.data);
      emit(GetTop5MoviesSuccessState(top5Movies!));
    }).catchError((error) {
      print(error.toString());
      emit(GetTop5MoviesErrorState(error));
    });
  }

  Future getMovieDetails({required int id}) async {
    emit(GetMovieDetailsLoadingState());
    DioHelper.getData(endPoint: '/movie/$id').then((value) async {
      print(value);

      movieDetails = MovieDetails.fromJson(value.data);
      emit(GetMovieDetailsSuccessState(movieDetails!));
    }).catchError((error) {
      print(error.toString());

      emit(GetMovieDetailsErrorState(error.toString()));
    });
  }

  String? videoKey;

  Future getMovieTrailer({required int id, required String movieOrTv}) async {
    videoKey = '';
    emit(GetMovieTrailerLoadingState());
    await DioHelper.getData(endPoint: '/$movieOrTv/$id/videos').then((value) {
      print(value);

      final trailer = VideoModel.fromJson(value.data);

      String? trailerKey = trailer.results!
          .firstWhere((element) =>
              element.site == 'YouTube' && element.type == 'Trailer')
          .key;
      print(trailerKey);

      videoKey = trailerKey;

      emit(GetMovieTrailerSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetMovieTrailerErrorState());
    });
  }

  Future getMovies({int page = 1}) async {
    emit(GetMoviesLoadingState());
    DioHelper.getData(endPoint: '/movie/popular', page: page).then((value) {
      print(value);
      popularMovies = MovieModel.fromJson(value.data);
      setLength(10);
      emit(GetMoviesSuccessState(popularMovies!));
    }).catchError((error) {
      print(error.toString());
      emit(GetMoviesErrorState(error));
    });
  }

  Future getSerieDetails({required int id}) async {
    emit(GetSerieDetailsLoadingState());
    DioHelper.getData(endPoint: '/tv/$id').then((value) {
      print(value);
      serieDetails = MovieDetails.fromJson(value.data);
      emit(GetSerieDetailsSuccessState(serieDetails!));
    }).catchError((error) {
      print(error.toString());
      emit(GetSerieDetailsErrorState(error));
    });
  }

  Future getTop5Series() async {
    emit(GetTop5SeriesLoadingState());
    DioHelper.getData(endPoint: '/tv/top_rated').then((value) {
      print(value);
      top5Series = MovieModel.fromJson(value.data);
      emit(GetTop5SeriesSuccessState(top5Movies!));
    }).catchError((error) {
      print(error.toString());

      emit(GetTop5SeriesErrorState(error.toString()));
    });
  }

  Future getSeries({int page = 1}) async {
    emit(GetTop5SeriesLoadingState());
    DioHelper.getData(endPoint: '/tv/popular', page: page).then((value) {
      print(value);
      popularSeries = MovieModel.fromJson(value.data);
      setLength(10);
      emit(GetTop5SeriesSuccessState(popularSeries!));
    }).catchError((
      error,
    ) {
      print(error.toString());

      emit(GetTop5SeriesErrorState(error.toString()));
    });
  }

  void setLength(int length_) {
    length = length_;
    emit(SetLengthState());
  }
}
