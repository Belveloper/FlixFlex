import 'package:flixflex/models/movie_details.dart';
import 'package:flixflex/models/movie_model.dart';


abstract class MovieStates {}

class MovieInitState extends MovieStates {}

class ToggleTabState extends MovieStates {}

class SetLengthState extends MovieStates {}

class GetMovieDetailsLoadingState extends MovieStates {}

class GetMovieDetailsSuccessState extends MovieStates {
  MovieDetails movie;

  GetMovieDetailsSuccessState(this.movie);
}

class GetMovieDetailsErrorState extends MovieStates {
  String error;

  GetMovieDetailsErrorState(this.error);
}

class GetMovieTrailerLoadingState extends MovieStates {}

class GetMovieTrailerSuccessState extends MovieStates {}

class GetMovieTrailerErrorState extends MovieStates {}

class GetTop5MoviesLoadingState extends MovieStates {}

class GetTop5MoviesSuccessState extends MovieStates {
  MovieModel movie;

  GetTop5MoviesSuccessState(this.movie);
}

class GetTop5MoviesErrorState extends MovieStates {
  String error;

  GetTop5MoviesErrorState(this.error);
}

class GetMoviesLoadingState extends MovieStates {}

class GetMoviesSuccessState extends MovieStates {
  MovieModel movie;

  GetMoviesSuccessState(this.movie);
}

class GetMoviesErrorState extends MovieStates {
  String error;

  GetMoviesErrorState(this.error);
}

class GetSerieDetailsLoadingState extends MovieStates {}

class GetSerieDetailsSuccessState extends MovieStates {
  MovieDetails movie;

  GetSerieDetailsSuccessState(this.movie);
}

class GetSerieDetailsErrorState extends MovieStates {
  String error;

  GetSerieDetailsErrorState(this.error);
}

class GetTop5SeriesLoadingState extends MovieStates {}

class GetTop5SeriesSuccessState extends MovieStates {
  MovieModel movie;

  GetTop5SeriesSuccessState(this.movie);
}

class GetTop5SeriesErrorState extends MovieStates {
  String error;

  GetTop5SeriesErrorState(this.error);
}

class GetSeriesLoadingState extends MovieStates {}

class GetSeriesSuccessState extends MovieStates {
  MovieModel movie;

  GetSeriesSuccessState(this.movie);
}

class GetSeriesErrorState extends MovieStates {
  String error;

  GetSeriesErrorState(this.error);
}