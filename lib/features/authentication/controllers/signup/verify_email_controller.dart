import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/loader/loaders.dart';
import 'package:sport_shoes_store/data/repositories/authentication_repository.dart';
import 'package:sport_shoes_store/features/authentication/screens/signup/success_screen.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/text_strings.dart';
// Quản lý quá trình xác minh email.
class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();
  @override
  void onInit() { // kiểm tra xem email đã được xác minh chưa và tự động chuyển hướng nếu đã xác minh
    // sendEmailVerification();
    // setTimerForAutoRedirect();
    checkEmailVerificationStatus();
    super.onInit();
  }

  // sendEmailVerification() async {
  //   try {
  //     await AuthenticationRepository.instance.sendEmailVerification();
  //     Loaders.successSnackBar(
  //         title: 'Success!',
  //         message: 'Please check your inbox and verify your email. ');
  //   } catch (e) {
  //     Loaders.errorSnackBar(title: 'Error!', message: e.toString());
  //   }
  // }

  /// Timer to automatically redirect on Email Verification
  // setTimerForAutoRedirect() {
  //   Timer.periodic(const Duration(seconds: 1), (timer) async {
  //     await FirebaseAuth.instance.currentUser?.reload();
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user?.emailVerified ?? false) {
  //       timer.cancel();
  //       Get.offAll(() => SuccessScreen(
  //             image: Images.product1,
  //             title: TextString.yourAccountCreatedTitle,
  //             subTitle: TextString.yourAccountCreatedSubTitle,
  //             onPressed: () => AuthenticationRepository.instance.sendEmailVerification(),
  //           ));
  //     }
  //   });
  // }

  /// Manually check if email verification
  checkEmailVerificationStatus() async {
    // Kiểm tra xem email của người dùng hiện tại đã được xác minh chưa. Nếu đã xác minh, nó sẽ chuyển hướng đến SuccessScreen
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified){
      Get.offAll(() => SuccessScreen(
        image: Images.product1,
        title: TextString.yourAccountCreatedTitle,
        subTitle: TextString.yourAccountCreatedSubTitle,
        onPressed: () => AuthenticationRepository.instance.screenRedirect(),
      ));
    }
  }
}
