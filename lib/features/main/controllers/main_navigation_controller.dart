import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxInt previousIndex = 0.obs;
  final RxSet<int> _loadedTabs = <int>{0}.obs;

  Set<int> get loadedTabs => _loadedTabs;

  void changeTab(int index) {
    if (index == currentIndex.value) return;
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
    _loadedTabs.add(index);
  }

  void goToPreviousTab() {
    changeTab(previousIndex.value);
  }
}
