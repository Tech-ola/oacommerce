
import 'package:ecommerce/data/repositories/categories/category_repository.dart';
import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories =  <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories =  <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // Load category data 
  Future<void> fetchCategories() async {
    try {
      // show loader 
      isLoading.value = true;

      // fetch categories 
      final categories = await _categoryRepository.getAllCategories();

      // update the categories list 
      allCategories.assignAll(categories);

      // Filter featured categories 
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());


    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove loader 
      isLoading.value = false;
    }
  }

// LOAD SELECTED CATEGORY DATA 
Future<List<CategoryModel>> getSubCategories(String categoryId) async {
  try{
    
    final subCategories = await _categoryRepository.getSubCategories(categoryId);
    return subCategories;
  }catch(e){
    TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    return [];
  }

}

// gET CATEGORY OR SUB 
Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
  // fetch limited 4 products 
  try{
  
    final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);
  return products; 

  }catch(e){
    TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    return [];
  }
}
 
}