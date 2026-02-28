import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../core/constant.dart';
import '../core/routes/routes_path.dart';
import '../model/product.dart';

enum ProductCategory { all, electronics, jewelery }

extension ProductCategoryLabel on ProductCategory {
  String get label {
    switch (this) {
      case ProductCategory.all:
        return "All";
      case ProductCategory.electronics:
        return "Electronics";
      case ProductCategory.jewelery:
        return "Jewelry";
      // case ProductCategory.mens:
      //   return "Men";
      // case ProductCategory.womens:
      //   return "Women";
    }
  }

  String? get apiCategory {
    switch (this) {
      case ProductCategory.all:
        return null;
      case ProductCategory.electronics:
        return "electronics";
      case ProductCategory.jewelery:
        return "jewelery";
      // case ProductCategory.mens:
      //   return "men's clothing";
      // case ProductCategory.womens:
      //   return "women's clothing";
    }
  }
}

class HomeController extends GetxController {
  var loading = true.obs;

  late TabController tabController;
  final ScrollController scrollController = ScrollController();
  final categories = ProductCategory.values;

  final RxMap<ProductCategory, List<Product>> categoryProducts = {for (var c in ProductCategory.values) c: <Product>[]}.obs;

  void initTabController(TickerProvider vsync) {
    tabController = TabController(length: categories.length, vsync: vsync);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex.value = tabController.index;
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllCategories();
  }

  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  Future<void> fetchCategory(ProductCategory category, {bool reset = false}) async {
    if (reset) categoryProducts[category]!.clear();

    final String urlString;

    if (category == ProductCategory.all) {
      urlString = '${WebService.urlBase}${EndPoint.products}';
    } else {
      urlString = '${WebService.urlBase}${EndPoint.category}${category.apiCategory}';
    }

    final response = await http.get(Uri.parse(urlString));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      categoryProducts[category]!.addAll(data.map((e) => Product.fromJson(e)));
    }
  }

  Future<void> fetchAllCategories({bool reset = true}) async {
    loading.value = true;
    await Future.wait(categories.map((c) => fetchCategory(c, reset: reset)));
    loading.value = false;
  }

  Future<void> refreshAllCategories() async => fetchAllCategories(reset: true);

  List<Product> getByCategory(ProductCategory category) => categoryProducts[category] ?? [];

  void goToProfile() => Get.toNamed(RoutePaths.profile);

  @override
  void onClose() {
    tabController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
