
import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit(){
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async{
    try{
      // Show loader
      isLoading.value = true;

      // FETCH PRODUCTS 
      final products = await productRepository.getFeaturedProducts();

      // Assing products 
      featuredProducts.assignAll(products);


    } catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    } finally {
      isLoading.value = false;
    }
  }

  // Get alll prodouct 
    Future<List<ProductModel>> fetchAllFeaturedProducts() async{
    try{
      // FETCH PRODUCTS 
      final products = await productRepository.getAllFeaturedProducts();
      return products;

    } catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    } 
  }

  // Get the product price 
  String getProductPrice(ProductModel product){
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    // if no variation 
    if(product.productType == ProductType.single.toString()){
      return (product.salePrice > 0 ? product.salePrice : product.price).toString();
    }else{
      for(var variation in product.productVariations!){
        // determine the price to cosider 
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // update smallest and largets price 
        if(priceToConsider < smallestPrice){
          smallestPrice = priceToConsider;
        }

        if(priceToConsider > largestPrice){
          largestPrice = priceToConsider;
        }
      }

      if(smallestPrice.isEqual(largestPrice)){
        return largestPrice.toString();
      }else{
        return '$smallestPrice - \NGN $largestPrice';
      }
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice){
    if(salePrice == null || salePrice <= 0.0) return null;
    if(originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice * 100);
    return percentage.toStringAsFixed(0);
  }

  // check product stock 
  String getProductStockStatus(int stock){
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}

