import 'package:flutter/material.dart';
import 'package:flutter_bloc/ApiResponse.dart';
import 'package:flutter_bloc/MovieBloc.dart';
import 'package:flutter_bloc/MovieResponse.dart';

void main() {
  runApp(MovieScreen());
}

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  MovieBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MovieBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Movie Mania')),
        backgroundColor: Colors.black54,
        body: RefreshIndicator(
          onRefresh: () => _bloc.fetchMovieList(),
          child: StreamBuilder<ApiResponse<List<Movie>>>(
            stream: _bloc.movieListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    print(snapshot.data.message);
                    return Container();/*Loading(
                      loadingMessage: snapshot.data.message,
                    );*/

                    break;
                  case Status.COMPLETED:
                    print(snapshot.data.data);
                    return Container();
                    /*MovieList(movieList: snapshot.data.data);
                    */break;
                  case Status.ERROR:
                    print(snapshot.data.data);
                    return Container();

                    /*Error(
                      errorMessage: snapshot.data.message,
                      onRetryPressed: () => _bloc.fetchMovieList(),
                    );*/
                    break;
                }
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
