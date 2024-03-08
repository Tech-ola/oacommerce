
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if(query == null) return [];

      final products = await repository.fetchProductsByQuery(query);
      return products;
    } catch (e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }

  }


void sortProducts (String sortOption){
  selectedSortOption.value = sortOption;

  switch (sortOption){
    case 'Name' :
    products.sort((a, b) => a.title.compareTo(b.title));
    break;

    case 'Higher Price' :
    products.sort((a, b) => a.price.compareTo(b.price));
    break;

    case 'Lower Price' :
    products.sort((a, b) => a.price.compareTo(b.price));
    break;

   case 'Newest':
    products.sort((a, b) {
        if (a.date != null && b.date != null) {
            return b.date!.compareTo(a.date!);
        } else {
            // Handle the case when date is null for either a or b
            // For example, you might want to consider null dates as the smallest or largest
            // depending on your requirement.
            // Here, I'm assuming null dates are considered the smallest.
            if (a.date == null && b.date == null) {
                return 0; // Both dates are null, consider them equal
            } else if (a.date == null) {
                return 1; // Null date (a) should come after non-null date (b)
            } else {
                return -1; // Non-null date (b) should come after null date (a)
            }
        }
    });
    break;



    case 'Sale' :
    products.sort((a, b) {
      if(b.salePrice > 0) {
        return b.salePrice.compareTo(a.salePrice);
      }else if(a.salePrice > 0) {
        return -1;
      }else {
        return 1;
      }
    });
    break;
    default:
    products.sort((a, b) => a.title.compareTo(b.title));
  }
}

void assignProducts(List<ProductModel> products){
  // Assign products to the products list 
  this.products.assignAll(products);
  sortProducts('Name');
}
}