import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:movie_detail/model/movie_scoped_model.dart';
import 'package:dio/dio.dart';
import 'package:movie_detail/utils/constant.dart';
import 'package:movie_detail/pojo/film_pojo.dart';
import 'dart:convert';
import './screen/movie_detail.dart';
import 'package:movie_detail/custom/spin_kit_ripple.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    // removes the debug banner
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepOrange),
  ));
}

class Home extends StatelessWidget {

  void httpRequest(MovieScopedModel model) async {
    var dio = Dio();
    Response response = await dio.get(Constant.filmUrl);
    List data = jsonDecode(response.data);
    List<Film> filmList = data.map((f) => Film.fromJson(f)).toList();
    //print(filmList[0].title);
    model.setLoading(false);
    model.setFilm(filmList);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: MovieScopedModel(),
      child: ScopedModelDescendant<MovieScopedModel>(
        builder: (BuildContext context, Widget child, MovieScopedModel model) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Movies',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontFamily: Constant.fontRegular,
                      fontWeight: FontWeight.bold),
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      model.setLoading(true);
                      httpRequest(model);
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 22.0,
                    ),
                  )
                ],
              ),
              body: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: ScopedModelDescendant<MovieScopedModel>(
                  builder: (BuildContext context, Widget child,
                      MovieScopedModel model) {
                    return Container(
                      child: model.getLoading()
                          ? Center(
                              child: SpinKitRipple(
                                color: <Color>[
                                  Colors.red,
                                  Colors.green,
                                  Colors.blue,
                                  Colors.deepOrange
                                ],
                              ),
                            )
                          : _buildCard(model),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildCard(MovieScopedModel model) {
  return model.film != null
      ? Container(
          color: Colors.white,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Stack(
                          children: <Widget>[
                            FadeInImage(
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              image: NetworkImage(
                                model.film[index].poster,
                              ),
                              placeholder:
                                  AssetImage('assets/images/placeholder.png'),
                            ),
                            Opacity(
                              opacity: 0.6,
                              child: Container(
                                color: Colors.black,
                              ),
                            ),
                            Center(
                              child: Hero(
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    '${model.film[index].title}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: Constant.fontRegular),
                                  ),
                                ),
                                tag: '${model.film[index].title}',
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MovieDetail(film: model.film[index])));
                  },
                ),
              );
            },
            itemCount: model.film.length,
          ),
        )
      : Container();
}
