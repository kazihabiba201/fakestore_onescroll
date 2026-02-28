import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../core/app_string.dart';
import '../core/constant.dart';
import '../model/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController controller = Get.put(HomeController());
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    controller.initTabController(this);
    pageController = PageController(initialPage: controller.currentIndex.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.refreshAllCategories,
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                floating: false,
                backgroundColor: Colors.orange,
                title:const Text(AppStrings.shopName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: controller.goToProfile,
                      icon: const Icon(Icons.person),
                      color: Colors.white,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.orange, Colors.pink]),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: kToolbarHeight),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              height: AppSizes.searchBarHeight,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search, color: Colors.orange,),
                                  hintText: AppStrings.searchBarText,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              height: AppSizes.flashBannerHeight,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  AppStrings.bannerText,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarDelegate(
                  TabBar(
                    controller: controller.tabController,
                    tabs: controller.categories.map((e) => Tab(text: e.label)).toList(),
                    indicatorColor: Colors.orange,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    onTap: (index) {
                      controller.currentIndex.value = index;
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity == null) return;
                    if (details.primaryVelocity! < 0) {
                      if (controller.currentIndex.value < controller.categories.length - 1) {
                        controller.currentIndex.value++;
                        controller.tabController.animateTo(controller.currentIndex.value);
                      }
                    } else if (details.primaryVelocity! > 0) {
                      if (controller.currentIndex.value > 0) {
                        controller.currentIndex.value--;
                        controller.tabController.animateTo(controller.currentIndex.value);
                      }
                    }
                  },
                  child: Column(
                    children: List.generate(
                      controller.getByCategory(controller.categories[controller.currentIndex.value]).length,
                      (index) {
                        final item = controller.getByCategory(controller.categories[controller.currentIndex.value])[index];
                        return SizedBox(
                          height: 180,
                          child: ProductCard(item),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                product.image ?? '',
                width: double.infinity,
                fit: BoxFit.fitHeight,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Price: ${product.price.toString()}\$',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(color: Colors.white, child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_) => false;
}
