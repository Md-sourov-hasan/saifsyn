import 'package:get/get.dart';
import 'package:saifsyn/features/subscription/controllers/subscription_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LogInController>(
    //       () => LogInController(),
    //   fenix: true,
    // );
    Get.put(SubscriptionController());
  }
}
