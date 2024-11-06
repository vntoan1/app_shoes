import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/loader/loaders.dart';
import 'package:sport_shoes_store/data/repositories/user_repository.dart';
import 'package:sport_shoes_store/features/authentication/controllers/signup/network_manager.dart';
import 'package:sport_shoes_store/features/authentication/models/user_model.dart';
import 'package:sport_shoes_store/features/authentication/screens/home/home.dart';
import 'package:sport_shoes_store/features/authentication/screens/login/login.dart';
import 'package:sport_shoes_store/features/authentication/screens/signup/vefify_email.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/popups/full_screen_loader.dart';

import '../../../../data/repositories/authentication_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  //cho phép các phần khác của ứng dụng dễ dàng truy cập vào phiên bản bộ điều khiển bằng cách sử dụng SignupController.instance. Get.find()Phương pháp này tìm phiên bản bộ điều khiển đã được tạo và đăng ký trong bộ nhớ.
  final hidePassword = true.obs; // ẩn mật khẩu
  final privacyPolicy = true.obs; // chính sách bảo mật
  final email = TextEditingController(); // dùng để thu thập thông tin đầu vào từ người dùng trong biểu mẫu đăng ký.
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
      //Xác thực biểu mẫu vớiGlobalKey<FormState>.
  void singUp() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'We are processing your information ...', Images.product1);
      // thông báo cho người dùng biết rằng quá trình đăng ký đã bắt đầu.
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      //sử dụng NetworkManager kiểm tra có kết nối internet
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }
    // Trạng thái hiện tại của biểu mẫu được xác thực bằng validate()
      if (!privacyPolicy.value) {
        Loaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you mush have to read and accept the Privacy');
        return;
      } // chính sách bảo mật

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
        // Phương registerWithEmailAndPasswordthức được gọi, trả về userCredentialkhi thành công. Đối tượng này chứa thông tin về người dùng mới được tạo.
              email.text.trim(), password.text.trim());
      // tạo người dùng trong firebase
      final newUser = UserModel(
          id: userCredential.user!.uid,
          email: email.text.trim(),
          firstName: firstName.text.trim(),
          username: userName.text.trim(),
          lastName: lastName.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      // Điều này đảm bảo thông tin của người dùng được lưu trữ cục bộ hoặc trên máy chủ, tùy thuộc vào cách triển khai kho lưu trữ
      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'You account has been created! Verify email to continue!');
      // Thanh thông báo thành công sẽ hiển thị, thông báo cho người dùng rằng tài khoản của họ đã được tạo và họ cần xác minh email để tiếp tục.
      Get.to(() => VerifyEmailScreen(email: email.text.trim(),));
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
