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
  final rememberMe = false.obs;  //theo dõi xem người dùng có muốn lưu thông tin đăng nhập của họ hay không
  final hidePassword =  true.obs; // xác định xem mật khẩu có bị ẩn hay không.
  final localStorage = GetStorage(); // lưu trữ
  final email = TextEditingController(); // ghi lại thông tin đầu vào
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(); //để xác thực biểu mẫu đăng nhập.
  final userController = Get.put(UserController());

  Future<void> emailAndPasswordSignIn() async {
    try{
      // Check internet connectivity
      FullScreenLoader.openLoadingDialog( // hiển thị hộp thoại tải bằng cách sử dụng FullScreenLoader
          'Login...', Images.product1);
      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected(); // kiểm tra kết nối
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // if (!loginFormKey.currentState!.validate()) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }
      //save data if remember me í selected
      if(rememberMe.value){ //Lưu thông tin đăng nhập nếu rememberMeđúng.
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
// xác thực người dùng bằng email và mật khẩu được cung cấp thông qua AuthenticationRepository
      FullScreenLoader.stopLoading(); // Dừng trình tải và chuyển hướng khi thành công.

      AuthenticationRepository.instance.screenRedirect();
    }catch(e){
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Đăng nhập thất bại', message: e.toString());
    }
  }//Xử lý mọi lỗi bằng cách hiển thị thanh thông báo lỗi.

  Future<void> googleSignIn() async { //Thử đăng nhập Google
    try{
      FullScreenLoader.openLoadingDialog('Login you in...', Images.product1);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();
      await userController.saveUserRecord(userCredentials);
      //Khi thành công, lưu hồ sơ người dùng qua userControllervà chuyển hướng người dùng.
      FullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    }catch(e){
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}