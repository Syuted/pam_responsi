import 'base_network.dart';

class APIService {
  static APIService instance = APIService();

  Future<Map<String, dynamic>> loadCategories() {
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadMeals(String category) {
    return BaseNetwork.get("filter.php?c=" + category);
  }

  Future<Map<String, dynamic>> loadDetail(String id) {
    return BaseNetwork.get("lookup.php?i=" + id);
  }
}
