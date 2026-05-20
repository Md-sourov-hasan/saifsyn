import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/routes/app_routes.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final localizationService = Get.find<LocalizationService>();

  void _selectLanguage(String language) {
    if (language == 'English') {
      localizationService.changeLocale(const Locale('en'));
    } else {
      localizationService.changeLocale(const Locale('ar'));
    }
    setState(() {});

    Future.delayed(const Duration(milliseconds: 100), () {
      Get.offNamed(AppRoute.getOnBoardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF00008B),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: width * 0.75,
                  padding: EdgeInsets.symmetric(vertical: height * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.05),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        localizationService.translate('selectLanguage'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.06,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        localizationService.translate('selectLanguageAr'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.05,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                      _languageButton(
                        width: width,
                        label: localizationService.translate('languageEnglish'),
                        isSelected: localizationService.locale.languageCode == 'en',
                        onTap: () => _selectLanguage('English'),
                      ),
                      SizedBox(height: height * 0.02),
                      _languageButton(
                        width: width,
                        label: localizationService.translate('languageArabic'),
                        isSelected: localizationService.locale.languageCode == 'ar',
                        onTap: () => _selectLanguage('العربية'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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

  Widget _languageButton({
    required double width,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.45,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.08,
          vertical: width * 0.035,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00008B) : Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: isSelected
              ? []
              : const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                  )
                ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: width * 0.04,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
