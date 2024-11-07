import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sport_shoes_store/data/controller/user_controller.dart';
import 'package:sport_shoes_store/data/repositories/authentication_repository.dart';
import 'package:sport_shoes_store/features/authentication/controllers/signup/network_manager.dart';
import 'package:sport_shoes_store/utils/popups/full_screen_loader.dart';

import '../../../../common/widgets/loader/loaders.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../screens/signup/vefify_email.dart';

class LoginController extends GetxController{
  final rememberMe = false.obs;
  final hidePassword =  true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  Future<void> emailAndPasswordSignIn() async {
    try{
      // Check internet connectivity
      FullScreenLoader.openLoadingDialog(
          'Login...', Images.product1);
      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // if (!loginFormKey.currentState!.validate()) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }
      //save data if remember me í selected
      if(rememberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      FullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    }catch(e){
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Đăng nhập thất bại', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try{
      FullScreenLoader.openLoadingDialog('Login you in...', Images.product1);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();
      await userController.saveUserRecord(userCredentials);
      FullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    }catch(e){
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}