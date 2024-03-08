import 'package:ecommerce/data/repositories/banners/banner_repository.dart';
import 'package:ecommerce/features/shop/models/banner_model.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BannerController extends GetxController{

  // Variables 
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit(){
    fetchBanners();
    super.onInit();
  }
  

  // Update page navigational dots 
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  // fetch banners 
    Future<void> fetchBanners() async {
    try {
      // show loader 
      isLoading.value = true;

      // Fetch banners 
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      // Assign banners 
      this.banners.assignAll(banners);

    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove loader 
      isLoading.value = false;
    }
  }

}