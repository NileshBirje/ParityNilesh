import 'package:flutter/material.dart';
import 'package:flutter_application_nilesh/app/common_widgets/main_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<HomeController>();/
    if (!Get.isRegistered<HomeController>()) {
      Get.lazyPut(() => HomeController());
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
          bottom: TabBar(controller: controller.tabCont, tabs: const [
            Tab(
              child: Text('Top'),
            ),
            Tab(
              child: Text('Popular'),
            ),
            Tab(
              child: Text('Featured'),
            ),
          ]),
        ),
        // floatingActionButton: FloatingActionButton(onPressed: () => controller.firstLoad(),),
        body: TabBarView(
          controller: controller.tabCont,
          children: [
            Obx(
              () => controller.isTopFirstLoadRunning.value
                  ? SizedBox(
                      height: 1.sh,
                      child: Center(
                        child: SizedBox(
                          height: 20.h,
                          child: const CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                    controller: controller.topScroller,
                    child: Column(
                        children: [
                          ListView.builder(shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.displayTopData.length,
                            itemBuilder: (context, index) {
                              return MainCard(
                                  image: controller
                                          .displayTopData[index].imageMedium ??
                                      '',
                                  title: controller
                                          .displayTopData[index].store!.name ??
                                      '',
                                  likeCount: '1',
                                  commentCount: controller
                                      .displayTopData[index].commentsCount!
                                      .toString(),
                                  date: '${DateTime.now()}');
                            },
                          )
                        ],
                      ),
                  ),
            ),
            Obx(
              () => controller.isPopularFirstLoadRunning.value
                  ? SizedBox(
                      height: 1.sh,
                      child: Center(
                        child: SizedBox(
                          height: 20.h,
                          child: const CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                    controller: controller.popularScroller,
                    child: Column(
                        children: [
                          ListView.builder(shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.displayPopularData.length,
                            itemBuilder: (context, index) {
                              return MainCard(
                                  image: controller
                                          .displayPopularData[index].imageMedium ??
                                      '',
                                  title: controller
                                          .displayPopularData[index].store!.name ??
                                      '',
                                  likeCount: '1',
                                  commentCount: controller
                                      .displayPopularData[index].commentsCount!
                                      .toString(),
                                  date: '${DateTime.now()}');
                            },
                          )
                        ],
                      ),
                  ),
            ),
            Obx(
              () => controller.isFeaturedFirstLoadRunning.value
                  ? SizedBox(
                      height: 1.sh,
                      child: Center(
                        child: SizedBox(
                          height: 20.h,
                          child: const CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                    controller: controller.featureScroller,
                    child: Column(
                        children: [
                          ListView.builder(shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.displayFeaturedData.length,
                            itemBuilder: (context, index) {
                              return MainCard(
                                  image: controller
                                          .displayFeaturedData[index].imageMedium ??
                                      '',
                                  title: controller
                                          .displayFeaturedData[index].store!.name ??
                                      '',
                                  likeCount: '1',
                                  commentCount: controller
                                      .displayFeaturedData[index].commentsCount!
                                      .toString(),
                                  date: '${DateTime.now()}');
                            },
                          )
                        ],
                      ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
