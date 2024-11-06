import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/loader/loaders.dart';
import 'package:sport_shoes_store/data/controller/user_controller.dart';
import 'package:sport_shoes_store/data/repositories/user_repository.dart';
import 'package:sport_shoes_store/features/authentication/controllers/signup/network_manager.dart';
import 'package:sport_shoes_store/features/personalization/screens/profile/profile.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/popups/full_screen_loader.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try{
      FullScreenLoader.openLoadingDialog('We are updating your information...', Images.onBoardingImage3);

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if(!updateUserNameFormKey.currentState!.validate()){
        FullScreenLoader.stopLoading();
        return;
      }

      // update user in the firebase
      Map<String, dynamic> name = {'FirstName' : firstName.text.trim(),'LastName' : lastName.text.trim()};
      await userRepository.updateSingleField(name);

      // update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      FullScreenLoader.stopLoading();

      Loaders.successSnackBar(title: 'Congratulations', message: 'Your name ...');
      Get.off(() => const ProfileScreen());
    }catch(e){
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}