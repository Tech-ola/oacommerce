import 'package:ecommerce/bindings/general_bindings.dart';
import 'package:ecommerce/routes/app_routes.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
       themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        initialBinding: GeneralBindings(),
        getPages: AppRoutes.pages,
        // Show Loader or circular progress indicator 
        // home: const OnBoardingScreen(),
        home: const Scaffold(backgroundColor: TColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white,),),),
    );
  }
}