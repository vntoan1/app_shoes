import 'package:get/get.dart';
import 'package:sport_shoes_store/features/authentication/screens/home/home.dart';
import 'package:sport_shoes_store/features/authentication/screens/login/login.dart';
import 'package:sport_shoes_store/features/authentication/screens/onboarding.dart';
import 'package:sport_shoes_store/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:sport_shoes_store/features/authentication/screens/signup/signup.dart';
import 'package:sport_shoes_store/features/authentication/screens/signup/vefify_email.dart';
import 'package:sport_shoes_store/features/personalization/screens/address/address.dart';
import 'package:sport_shoes_store/features/personalization/screens/profile/profile.dart';
import 'package:sport_shoes_store/features/personalization/screens/settings/setting.dart';
import 'package:sport_shoes_store/features/shop/screens/cart/cart.dart';
import 'package:sport_shoes_store/features/shop/screens/checkout/checkout.dart';
import 'package:sport_shoes_store/features/shop/screens/order/widgets/order.dart';
import 'package:sport_shoes_store/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:sport_shoes_store/features/shop/screens/store/store.dart';
import 'package:sport_shoes_store/features/shop/screens/wishlist/wishlist.dart';
import 'package:sport_shoes_store/routes/routes.dart';

class AppRoutes {
   static final pages = [
     GetPage(name: KRoutes.home, page: () => const HomeScreen()),
     GetPage(name: KRoutes.store, page: () => const StoreScreen()),
     GetPage(name: KRoutes.favourites, page: () => const FavoriteScreen()),
     GetPage(name: KRoutes.settings, page: () => const SettingScreen()),
     GetPage(name: KRoutes.productReviews, page: () => const ProductReviewsScreen()),
     GetPage(name: KRoutes.order, page: () => const OrderScreen()),
     GetPage(name: KRoutes.checkout, page: () => const CheckoutScreen()),
     GetPage(name: KRoutes.userProfile, page: () => const ProfileScreen()),
     GetPage(name: KRoutes.userAddress, page: () => const UserAddressScreen()),
     GetPage(name: KRoutes.signup, page: () => const SignUpScreen()),
     GetPage(name: KRoutes.verifyEmail, page: () => VerifyEmailScreen()),
     GetPage(name: KRoutes.forgetPassWord, page: () => const ForgetPassword()),
     GetPage(name: KRoutes.onBoarding, page: () => const OnBoardingScreen()),
   ];
}