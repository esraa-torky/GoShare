class Category {
  String categoryName;
  List<Map<String, dynamic>> products;
  Category(String _categoryName, List<Map<String, dynamic>> _products) {
    this.categoryName = _categoryName;
    this.products = _products;
  }
}
