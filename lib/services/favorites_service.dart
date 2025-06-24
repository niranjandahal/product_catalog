import 'package:shared_preferences/shared_preferences.dart';


class FavoritesService {


  static const String _favoritesKey = 'favorite_product_ids';


  Future<List<int>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey)?.map(int.parse).toList() ?? [];
  }


  Future<void> saveFavorites(List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _favoritesKey,
      ids.map((e) => e.toString()).toList(),
    );
  }


}