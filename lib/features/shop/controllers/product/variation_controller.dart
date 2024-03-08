
import 'package:ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce/features/shop/controllers/product/images_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  // Variables 
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;

  // select attribute 
  void onAttributeSelected(ProductModel product, attributeName, attributeValue){
    // when attribute is sslecte , add to selected attribute 
    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere((variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes), orElse: () => ProductVariationModel.empty() ,);

  // show selecte varaition 
  if(selectedVariation.image.isNotEmpty){
    ImagesController.instance.selectedProductImage.value = selectedVariation.image;
  }

  // show selected variation quanitty 
  if(selectedVariation.id.isNotEmpty){
    final cartController = CartController.instance;
    cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(product.id, selectedVariation.id);
  }

// Assing selectde varitio 
this.selectedVariation.value = selectedVariation;


  // update selecte attributs 
  getProductVariationStockStatus();
  }

  // check if selecte dattributs matches any varition attibuytes 
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes){
    // Rx selecte attributes contain 3 and variation as 2
    if(variationAttributes.length != selectedAttributes.length) return false;

    for(final key in variationAttributes.keys){
      // Attribute[key] =  value which could be Green, small, cotton 
      if(variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  // Check attribute 
  Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName) {
    final availableVariationAttributeValues = variations.where((variation) => variation.attributeValues[attributeName] != null && variation.attributeValues[attributeName]!.isNotEmpty && variation.stock > 0 ).map((variation) => variation.attributeValues[attributeName]).toSet();

    return availableVariationAttributeValues;
  }

  String getVariationPrice(){
    return (selectedVariation.value.salePrice > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }

  // chec product variation 
  void getProductVariationStockStatus(){
    variationStockStatus.value = selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

    // Reset selected attributes 
    void resetSelectedAttributes(){
      selectedAttributes.clear();
      variationStockStatus.value = '';
      selectedVariation.value = ProductVariationModel.empty();
    }
  }
