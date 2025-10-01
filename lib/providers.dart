import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = Provider<List<String>>((ref) => [
  "All",
  "Trending",
  "Recommended",
  "Best Seller",
]);

final selectedCategoryProvider = StateProvider<int>((ref) => 0);

final productsProvider = Provider<List<Map<String, String>>>((ref) {
  final selectedCategoryIndex = ref.watch(selectedCategoryProvider);
  final categories = ref.watch(categoriesProvider);
  final selectedCategory = categories[selectedCategoryIndex];

  final allProducts = [
    {
      "name": "Urban Edge",
      "price": "\$89.99",
      "image": "assets/sunglass1.jpg",
      "category": "Trending",
    },
    {
      "name": "Sunset Glair",
      "price": "\$69.49",
      "image": "assets/sunglass2.jpg",
      "category": "Best Seller",
    },
  ];

  if (selectedCategory == "All") return allProducts;

  return allProducts
      .where((product) => product["category"] == selectedCategory)
      .toList();
});
