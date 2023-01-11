import 'package:flixflex/controllers/Movies/cubit.dart';
import 'package:flixflex/models/movie_model.dart';
import 'package:flixflex/views/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loading() {
  int offset = 0;
  int time;
  return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        offset += 10;
        time = 800 + offset;
        return Shimmer.fromColors(
          period: Duration(milliseconds: time),
          highlightColor: const Color(0xFF1a1c20),
          baseColor: const Color(0xFF111111),
          child: Container(
            margin: const EdgeInsets.all(4.0),
            height: MediaQuery.of(context).size.height * 0.19,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 0,
                  height: MediaQuery.of(context).size.height * 0.19,
                  width: MediaQuery.of(context).size.height * 0.16,
                  child: Container(
                    width: 145,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget MovieWidget(
    {required BuildContext context,
    required Results movie,
    bool? isMovie,
    MovieCubit? cubit}) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => MovieDetailsScreen(
            isMovie: isMovie,
            index: movie.id!,
            movie: movie,
          ),
        ),
      );
    },
    child: SizedBox(
      height: 300,
      width: 230,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: movie.posterPath != null
                  ? Image.network(
                      "https://image.tmdb.org/t/p/original${movie.posterPath.toString()}",
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(height: 300, width: 230),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.purple.shade200,
                    //Colors.redAccent.withOpacity(.5),
                    Colors.purple.shade200.withOpacity(.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: SizedBox(
              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMovie! ? movie.title! : movie.name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.originalTitle ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        movie.voteAverage!.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget TabWidget(
    {required String title,
    required int index,
    required cubit,
    required BuildContext? context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16),
    child: InkWell(
      onTap: () => cubit.setTabIndex(index),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: cubit.tabIndex == index
                ? const Color.fromARGB(255, 118, 132, 255)
                : const Color(0xFF333333)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: MediaQuery.of(context!).size.width * 0.035,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
              fontFamily: "Poppins-Regular",
              color: cubit.tabIndex == index
                  ? Colors.white
                  : const Color(0xFF999999),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget defaultTextField(
        {IconData? icon,
        bool isObscure=false,
        IconButton? suffixIcon,
        String? hintText,
        TextStyle? hintStyle,
        String? Function(String?)? validate,
        Function(String?)? onSave,
        Function(String?)? onChng,
        Function(String?)? onsubmit,
        TextEditingController? controller}) =>
    Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade900,
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(5),
      height: 60,
      child: TextFormField(
        obscureText: isObscure,
        onFieldSubmitted: onsubmit,
        onChanged: onChng,
        onSaved: onSave,
        controller: controller,
        validator: validate,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          hintText: hintText,
          hintStyle:
              hintStyle ?? TextStyle(fontSize: 15, color: Colors.grey.shade200),
          border: InputBorder.none,
        ),
      ),
    );

Widget MovieWidgetTop(
    {required BuildContext context,
    required Results movie,
    required MovieCubit cubit,
    bool isMovie = true}) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(
            isMovie: isMovie,
            index: movie.id!,
            movie: movie,
          ),
        ),
      );
    },
    child: SizedBox(
      height: 300,
      width: 230,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: movie.posterPath != null
                  ? Image.network(
                      "https://image.tmdb.org/t/p/original${movie.posterPath.toString()}",
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(height: 300, width: 230),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.grey,
                    //Colors.redAccent.withOpacity(.5),
                    Colors.white.withOpacity(.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: SizedBox(
              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMovie ? movie.title! : movie.name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.originalTitle ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        movie.voteAverage!.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
