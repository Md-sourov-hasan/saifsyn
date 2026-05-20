import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/core.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

import '../../controllers/onboarding_controller.dart';
import '../../data/models/onboarding_models.dart';
import '../widgets/onboarding_skip_button.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_footer.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final OnboardingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OnboardingController(
      initialPageController: PageController(),
    );
  }

  @override
  void dispose() {
    _controller.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    final List<OnboardingPageModel> pages = [
      OnboardingPageModel(
        imagePath: ImagePath.onboardingImage1,
        title: localizationService.translate('onboardingTitle1'),
        description: localizationService.translate('onboardingDescription1'),
      ),
      OnboardingPageModel(
        imagePath: ImagePath.onboardingImage2,
        title: localizationService.translate('onboardingTitle2'),
        description: localizationService.translate('onboardingDescription2'),
      ),
      OnboardingPageModel(
        imagePath: ImagePath.onboardingImage3,
        title: localizationService.translate('onboardingTitle3'),
        description: localizationService.translate('onboardingDescription3'),
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFF00008B),
      body: SafeArea(
        child: Column(
          children: [
            OnboardingSkipButton(
              onTap: _controller.completeOnboarding,
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller.pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  _controller.currentPage.value = index;
                },
                itemBuilder: (context, index) {
                  return OnboardingContent(page: pages[index]);
                },
              ),
            ),
            ValueListenableBuilder<int>(
              valueListenable: _controller.currentPage,
              builder: (context, currentPage, _) {
                return OnboardingNextButton(
                  isLastPage: currentPage == pages.length - 1,
                  onTap: () {
                    if (currentPage < pages.length - 1) {
                      _controller.nextPage();
                    } else {
                      _controller.completeOnboarding();
                    }
                  },
                );
              },
            ),
            const OnboardingFooter(),
          ],
        ),
      ),
    );
  }
}
