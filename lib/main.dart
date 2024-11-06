import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/bindings/general_bindings.dart';
import 'package:sport_shoes_store/features/authentication/screens/onboarding.dart';
import 'package:sport_shoes_store/routes/app_routes.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/theme/theme.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repositories/authentication_repository.dart';
import 'features/authentication/screens/onboarding.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  await Firebase.initializeApp()
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: KAppTheme.lightTheme,
      themeMode: ThemeMode.system,
      darkTheme: KAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: const Scaffold(
        backgroundColor: ColorApp.blue02,
        body: Center(
          child: CircularProgressIndicator(
            color: ColorApp.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
