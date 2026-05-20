import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/core.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (StorageService.hasToken()) {
        Get.offNamed(AppRoute.getMainNavigationScreen());
      } else {
        Get.offNamed(AppRoute.getLanguageSelectionScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF00008B),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: height * 0.15),
            Container(
              width: width * 0.2,
              height: width * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.05),
                border: Border.all(
                  color: const Color(0xFF00008B),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.05),
                child: Image.asset(
                  ImagePath.upwardIcon,
                  fit: BoxFit.cover,
                  color: const Color(0xFF00008B),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Text(
              localizationService.translate('loginScreenTitle'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.075,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: height * 0.015),
            Text(
              localizationService.translate('loginScreenTitleAr'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.055,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: height * 0.08),
            Text(
              localizationService.translate('splashTitle'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.045,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Text(
                localizationService.translate('splashSubtitle'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFD0CCCC),
                  fontSize: width * 0.038,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              decoration: const BoxDecoration(
                color: Color(0xFF010196),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text(
                localizationService.translate('poweredBy'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.038,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
