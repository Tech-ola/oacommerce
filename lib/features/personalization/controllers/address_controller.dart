
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/data/repositories/address/address_repository.dart';
import 'package:ecommerce/features/authentication/models/address_model.dart';
import 'package:ecommerce/features/personalization/screens/address/add_new_address.dart';
import 'package:ecommerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddressController extends GetxController{
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController(); 

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();


  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  Future<List<AddressModel>> getAllUserAddresses() async {
    try{
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());
      return addresses;
    } catch(e){
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
    
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      TFullScreenLoader.openLoadingDialog('Storing Address...');

      // Clear selected field 
      if(selectedAddress.value.id.isNotEmpty){
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }

      // Assign selected address 
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the seleced field to true 
      await addressRepository.updateSelectedField(selectedAddress.value.id, true);

      TFullScreenLoader.stopLoading();

    } catch(e){
      TLoaders.errorSnackBar(title: 'Error in Selection', message: e.toString());
    }
  }

  // Add new adddress  
  Future addNewAddresses() async {
    try {
      // start loading 
      TFullScreenLoader.openLoadingDialog('Storing Address...');

      // Check internet 
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form validation 
      if(!addressFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // save address data 
      final address = AddressModel(
        id: '', 
        name: name.text.trim(), 
        phoneNumber: phoneNumber.text.trim(), 
        street: street.text.trim(), 
        city: city.text.trim(), 
        state: state.text.trim(), 
        postalCode: postalCode.text.trim(), 
        country: country.text.trim(),
        selectedAddress: true,
        );
        final id = await addressRepository.addAddress(address);

        // Update selected address status 
        address.id = id;
        await selectAddress(address);

        // Remove loader 
        TFullScreenLoader.stopLoading();

        // show success message 
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Your address has been saved successfully.');

        // Refresh addresses data 
        refreshData.toggle();

        // Reset fields 
        resetFormFields();

        // Redirect 
        Navigator.of(Get.context!).pop();

    }catch(e){
      // Remove loader 
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  // Rest form 
  void resetFormFields(){
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }

     // show addresses modal bottom sheet 
      Future<dynamic> selectNewAddressPopup(BuildContext context){
        return showModalBottomSheet(context: context, 
        builder: (_) => Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSectionHeading(title: 'Select Address', showActionButton: false,),
              FutureBuilder(future: getAllUserAddresses(), 
              builder: (_, snapshot){
                final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if(response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index)=> TSingleAddress(
                    address: snapshot.data![index], 
                    onTap: () async {
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    }));
              }),

              const SizedBox(height: TSizes.defaultSpace * 2,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => Get.to(() => const AddNewAddressScreen()), child: const Text('Add new address')),
              )
            ],
          ),
        ));
      }
}