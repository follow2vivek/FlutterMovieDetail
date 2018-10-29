import 'package:flutter/material.dart';
import 'package:movie_detail/pojo/film_pojo.dart';
import 'package:movie_detail/utils/constant.dart';
import 'package:movie_detail/custom/carousel_pro_widgets.dart';
import 'package:movie_detail/custom/start_rating.dart';

class MovieDetail extends StatelessWidget {
  final Film film;
  MovieDetail({Key key, @required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Hero(
            tag: film.title,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                film.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: Constant.fontRegular,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 200.0,
                  color: Colors.grey[200],
                  child: WidgetCarousel(
                    pages: film.images
                        .map((url) => FadeInImage(
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              image: NetworkImage(
                                url,
                              ),
                              placeholder:
                                  AssetImage('assets/images/placeholder.png'),
                            ))
                        .toList(),
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Theme.of(context).primaryColor,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.grey.withOpacity(0.0),
                    autoplayDuration: Duration(seconds: 2),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  height: 50.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: film.actors
                        .split(',')
                        .map<Widget>(
                          (f) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Chip(
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  label: Text(f,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: Constant.fontMedium,
                                      )),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Text(
                    film.plot,
                    style: TextStyle(
                        fontFamily: Constant.fontRegular,
                        color: Colors.grey[800]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Director -',
                        style: TextStyle(
                            fontFamily: Constant.fontRegular,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          film.director,
                          style: TextStyle(
                              fontFamily: Constant.fontRegular,
                              color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: FractionalOffset.centerLeft,
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        'Writer -',
                        style: TextStyle(
                            fontFamily: Constant.fontRegular,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          film.writer,
                          style: TextStyle(
                              fontFamily: Constant.fontRegular,
                              color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Language -',
                        style: TextStyle(
                            fontFamily: Constant.fontRegular,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          film.language,
                          style: TextStyle(
                              fontFamily: Constant.fontRegular,
                              color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: FractionalOffset.centerLeft,
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        'Awards -',
                        style: TextStyle(
                            fontFamily: Constant.fontRegular,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: <Widget>[
                            Text(
                              film.awards,
                              style: TextStyle(
                                  fontFamily: Constant.fontRegular,
                                  color: Colors.grey[500]),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: film.imdbRating != 'N/A'
                      ? StarRating(
                          color: Theme.of(context).primaryColor,
                          rating: double.parse(film.imdbRating),
                          starCount: 10,
                        )
                      : Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
