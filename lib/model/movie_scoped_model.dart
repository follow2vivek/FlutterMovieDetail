import 'package:scoped_model/scoped_model.dart';
import '../pojo/film_pojo.dart';

class MovieScopedModel extends Model {
  bool _isLoading = false;
  List<Film> _film;

  bool getLoading() {
    return _isLoading;
  }

  void setLoading(bool isLoading) {
    this._isLoading = isLoading;
    notifyListeners();
  }

  List<Film> getFilm() {
    return _film;
  }
  List<Film> get film => _film;

  void setFilm(List<Film> film) {
    this._film = film;
    notifyListeners();
  }
}
