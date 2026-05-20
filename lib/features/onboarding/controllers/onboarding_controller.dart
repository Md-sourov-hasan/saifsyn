import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/routes/app_routes.dart';

/// Controller / state holder for onboarding.
/// Keeps PageController and exposes current page as a ValueNotifier so
/// UI widgets can remain stateless and listen to changes.
class OnboardingController extends ChangeNotifier {
  final PageController pageController;
  final ValueNotifier<int> currentPage = ValueNotifier<int>(0);

  OnboardingController({PageController? initialPageController})
      : pageController = initialPageController ?? PageController() {
    // pageController is non-null here; add a listener to keep currentPage in sync.
    pageController.addListener(_onPageChangedFromController);
  }

  void _onPageChangedFromController() {
    final page = pageController.hasClients && pageController.page != null
        ? pageController.page!.round()
        : 0;
    if (currentPage.value != page) currentPage.value = page;
  }

  void jumpToPage(int page) {
    if (!pageController.hasClients) return;
    pageController.jumpToPage(page);
    currentPage.value = page;
  }

  void nextPage({Duration duration = const Duration(milliseconds: 300)}) {
    if (!pageController.hasClients) return;
    pageController.nextPage(duration: duration, curve: Curves.easeInOut);
  }

  void completeOnboarding() {
    Get.toNamed(AppRoute.getLoginScreen());
  }

  void disposeController() {
    pageController.removeListener(_onPageChangedFromController);
    pageController.dispose();
    currentPage.dispose();
  }
}
