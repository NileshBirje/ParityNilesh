import 'package:flutter/material.dart';
import 'package:flutter_application_nilesh/app/common_widgets/main_card.dart';
import 'package:flutter_application_nilesh/app/constants/style.dart';
import 'package:flutter_application_nilesh/app/utils/common_functions.dart';
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
          title:  Text('Deals',style: Style.regularText.copyWith(color: Style.whiteCol,fontWeight: FontWeight.bold),),
          // centerTitle: true,*------
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
        
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: controller.drawerItems.map((item) => ListTile(
                title: Text(item['title']!),
                subtitle: Text(item['subtitle']!),
                onTap: () {
                  Get.back();// Close the drawer
                  Func().showToast('${item['title']} clicked');
                },
              )).toList()
           /* 
          <Widget>[
           DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            )
            ..drawerItems.map((item) {
              return ListTile(
                title: Text(item['title']!),
                subtitle: Text(item['subtitle']!),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer
                  showToast('${item['title']} clicked');
                },
              );
            }).toList(),
          ],
            */
        ),
      ),
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
                          physics: const NeverScrollableScrollPhysics(),
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
                                  date: Func().returnDate(DateTime.now()));
                            },
                          ),
                        if(controller.isTopLoadMoreRunning.value)
                        const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      // When nothing else to load
                    if (controller.hasTopNextpage.value == false)
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: const Text('end of page'),
                      ),
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
                          physics: const NeverScrollableScrollPhysics(),
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
                                  date: Func().returnDate(DateTime.now()));
                            },
                          ),
                        if(controller.isPopularLoadMoreRunning.value)
                        const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      // When nothing else to load
                    if (controller.hasPopularNextpage.value == false)
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text('end of page'),),
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
                          physics: const NeverScrollableScrollPhysics(),
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
                                  date: Func().returnDate(DateTime.now()));
                            },
                          ),
                        if(controller.isFeaturedLoadMoreRunning.value)
                        const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      // When nothing else to load
                    if (controller.hasFeaturedNextpage.value == false)
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text('end of page'),),
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
