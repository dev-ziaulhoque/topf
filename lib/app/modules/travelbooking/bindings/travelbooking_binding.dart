import 'package:get/get.dart';

import '../controllers/travelbooking_controller.dart';

class TravelbookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelbookingController>(
      () => TravelbookingController(),
    );
  }
}
