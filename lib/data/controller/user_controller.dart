import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sport_shoes_store/common/widgets/loader/loaders.dart';
import 'package:sport_shoes_store/data/repositories/authentication_repository.dart';
import 'package:sport_shoes_store/data/repositories/user_repository.dart';
import 'package:sport_shoes_store/features/authentication/controllers/signup/network_manager.dart';
import 'package:sport_shoes_store/features/authentication/models/user_model.dart';
import 'package:sport_shoes_store/features/authentication/screens/login/login.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/popups/full_screen_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit(){
    super.onInit();
    fetchUserRecord();
  }

  // fetch user record
  Future<void> fetchUserRecord() async {
    try{
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    }catch(e){
      user(UserModel.empty());
    }finally{
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // first update Rx user and then check if user data is already stored. if not store new data
      await fetchUserRecord();
      //if no record already stored
      if(user.value.id.isEmpty){
        if (userCredential != null) {
          // convert name to first and last name
          final nameParts =
          UserModel.nameParts(userCredential.user!.displayName ?? '');
          final username =
          UserModel.generateUsername(userCredential.user!.displayName ?? '');

          // map data
          final user = UserModel(
              id: userCredential.user!.uid,
              lastName:nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              firstName: nameParts[0],
              username: username,
              email: userCredential.user!.email ?? '',
              phoneNumber: userCredential.user!.phoneNumber ?? '',
              profilePicture: userCredential.user!.photoURL ?? '');

          //save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      Loaders.warningSnackBar(
          title: 'Data not saved', message: 'Something went ...');
    }
  }

  // void deleteAccountWarningPopup(){
  //   Get.defaultDialog(
  //     contentPadding: const EdgeInsets.all(Sizes.md);
  //     title: 'Delete Account',
  //     middleText: 'Are you sure want ...',
  //     confirm: ElevatedButton(
  //         onPressed: () async => deleteUserAccount(),
  //       st
  //     ),
  //     cancel: OutlinedButton(
  //       child: const Text('Cancel'),
  //       onPressed: ()=> Navigatior.of(Get.overlayContext!).pop(),
  //     ),
  //   );
  // }
  //
  // void deleteUserAccount() async{
  //   try{
  //     FullScreenLoader.openLoadingDialog('Processing', Images.onBoardingImage3);
  //
  //     // First re-authenticate user
  //     final auth = AuthenticationRepository.instance;
  //     final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
  //     if(provider.isNotEmpty){
  //       if(provider == 'google.com'){
  //         await auth.delete,
  //         FullScreenLoader.stopLoading();
  //         Get.offAll(provider == 'password');
  //         Get.to(() => const ReAuthLoginForm());
  //       }
  //     }
  //   }catch(e){
  //     FullScreenLoader.stopLoading();
  //     Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
  //   }
  // }

  // Future<void> reAuthenticateEmailAndPasswordUser() async {
  //   try{
  //     FullScreenLoader.openLoadingDialog('Processing', Images.onBoardingImage3);
  //
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if(!isConnected){
  //       FullScreenLoader.stopLoading();
  //       return;
  //     }
  //
  //     if(!reAuthFormKey.currentState!.validate()){
  //       FullScreenLoader.stopLoading();
  //       return;
  //     }
  //     await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(email.text.trim(), password.text.trim());
  //     await AuthenticationRepository.instance.deleteAccount();
  //     FullScreenLoader.stopLoading();
  //     Get.offAll(() => const LoginScreen());
  //   }catch(e){
  //     FullScreenLoader.stopLoading();
  //     Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
  //   }
  // }

  Future<void> uploadUserProfilePicture() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if(image != null){
        imageUploading.value = true;
        // upload image
        final imageUrl = await userRepository.uploadImage('User/Images/Profile/', image);

        // update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        Loaders.successSnackBar(title: 'Congratulations', message: 'You profile image...');
      }
    }catch(e){
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      imageUploading.value = false;
    }
  }
}
