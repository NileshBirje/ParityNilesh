import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_nilesh/app/database/database.dart';
import 'package:flutter_application_nilesh/app/utils/common_functions.dart';
import 'package:flutter_application_nilesh/app/models/data_model.dart';
import 'package:flutter_application_nilesh/app/models/deals_model.dart';
import 'package:flutter_application_nilesh/app/models/user_model.dart';
import 'package:flutter_application_nilesh/app/modules/home/services/get_data.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement HomeController

  // ScrollController scroller = ScrollController();
  late ScrollController topScroller;
  late ScrollController popularScroller;
  late ScrollController featureScroller;
  late TabController tabCont;

  String url = '';

  final count = 0.obs;
  var currentPageTop = 1.obs;
  var currentPagePopular = 1.obs;
  var currentPageFeatured = 1.obs;

  RxBool isTopFirstLoadRunning = false.obs;
  RxBool isPopularFirstLoadRunning = false.obs;
  RxBool isFeaturedFirstLoadRunning = false.obs;

  RxBool isTopLoadMoreRunning = false.obs;
  RxBool isPopularLoadMoreRunning = false.obs;
  RxBool isFeaturedLoadMoreRunning = false.obs;

  RxBool hasTopFirstData = false.obs;
  RxBool hasPopularFirstData = false.obs;
  RxBool hasFeaturedFirstData = false.obs;

  RxBool hasTopMoreData = false.obs;
  RxBool hasPopularMoreData = false.obs;
  RxBool hasFeaturedMoreData = false.obs;

  RxBool hasTopNextpage = true.obs;
  RxBool hasPopularNextpage = true.obs;
  RxBool hasFeaturedNextpage = true.obs;

  RxInt selectedIndex = 0.obs;

  // DataModel data = DataModel();
  List<DealsModel> displayTopData = [];
  List<DealsModel> displayPopularData = [];
  List<DealsModel> displayFeaturedData = [];

  @override
  void onInit() {
    topScroller = ScrollController()..addListener(loadTopMore);
    popularScroller = ScrollController()..addListener(loadPopularMore);
    featureScroller = ScrollController()..addListener(loadFeaturedMore);
    tabCont = TabController(length: 3, vsync: this)
      ..addListener(
        () {
          selectedIndex.value = tabCont.index;

          // firstLoad(selectedIndex.value);
        },
      );

    firstLoad(0);
    firstLoad(1);
    firstLoad(2);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    print('is this it');
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future loadCache(int value) async{
    var cacheRes = await DatabaseHelper().getDeals(value);
      // await Func().getString('cacheData$value');

      if(cacheRes.isNotEmpty){

            if (value == 0) {
          displayTopData = cacheRes;
          hasTopFirstData.value = displayTopData.isNotEmpty;
          isTopFirstLoadRunning.value = false;
        } else if (value == 1) {
          displayPopularData = cacheRes;
          hasPopularFirstData.value = displayPopularData.isNotEmpty;
          isPopularFirstLoadRunning.value = false;
        } else {
          displayFeaturedData = cacheRes;
          hasFeaturedFirstData.value = displayFeaturedData.isNotEmpty;
          isFeaturedFirstLoadRunning.value = false;
        }

      }
  }

  Future firstLoad(int value) async {
    Func().dPrint('running api');

    if (value == 0) {
      isTopFirstLoadRunning.value = true;
      url =
          'http://stagingauth.desidime.com/v4/home/new?per_page=10&page=${currentPageTop.value}&fields=id,created_at,created_at_in_millis,image_medium,comments_count,store{name}';
    } else if (value == 1) {
      isPopularFirstLoadRunning.value = true;
      url =
          'http://stagingauth.desidime.com/v4/home/discussed?per_page=10&page=${currentPagePopular.value}&fields=id.created_at.created_at_in_millis,image_medium,comments_count,store{name} ';
    } else {
      isFeaturedFirstLoadRunning.value = true;
      url =
          'http://stagingauth.desidime.com/v4/home/discussed?per_page=10&page=${currentPageFeatured.value}&fields=id.created_at.created_at_in_millis,image_medium,comments_count,store{name} ';
    }

    await loadCache(value);

    await GetData().getData(url).then((resp) {
      if (resp != {}) {
        Func().dPrint("--first load-- ${resp}");
        
      Func().setString('cacheData$value', resp.toString());
    DatabaseHelper().insertDeal(resp as DealsModel,value);


        List<DealsModel>? list = (resp['deals'] as List<dynamic>)
            .map((e) => DealsModel.fromJson(e))
            .toList();

        if (value == 0) {
          displayTopData = list ?? [];
          hasTopFirstData.value = displayTopData.isNotEmpty;
          isTopFirstLoadRunning.value = false;
        } else if (value == 1) {
          displayPopularData = list ?? [];
          hasPopularFirstData.value = displayPopularData.isNotEmpty;
          isPopularFirstLoadRunning.value = false;
        } else {
          displayFeaturedData = list ?? [];
          hasFeaturedFirstData.value = displayFeaturedData.isNotEmpty;
          isFeaturedFirstLoadRunning.value = false;
        }
      } else {
        if (value == 0) {
          hasTopFirstData.value = false;
          isTopFirstLoadRunning.value = false;
        } else if (value == 1) {
          hasPopularFirstData.value = false;
          isPopularFirstLoadRunning.value = false;
        } else {
          hasFeaturedFirstData.value = false;
          isFeaturedFirstLoadRunning.value = false;
        }
      }
    });
  }

  void loadTopMore() async {
    currentPageTop.value++;
    url =
        'http://stagingauth.desidime.com/v4/home/new?per_page=10&page=${currentPageTop.value}&fields=id,created_at,created_at_in_millis,image_medium,comments_count,store{name}';
    if (hasTopNextpage.value == true &&
        isTopFirstLoadRunning.value == false &&
        isTopLoadMoreRunning.value == false) {
      isTopLoadMoreRunning.value = true;
      await GetData().getData(url).then((resp) {
        if (resp != {}) {
          Func().dPrint('--load more-- ${resp}');
          List<DealsModel>? list = (resp['deals'] as List<dynamic>)
              .map((e) => DealsModel.fromJson(e))
              .toList();
          if (list.isNotEmpty) {
            displayTopData.addAll(list);
            hasTopMoreData.value = true;
            hasTopNextpage.value = true;
          } else {
            hasTopMoreData.value = false;
            hasTopNextpage.value = false;
          }
          isTopLoadMoreRunning.value = false;
        } else {
          isTopLoadMoreRunning.value = false;
          hasTopMoreData.value = false;
          hasTopNextpage.value = false;
        }
      });
    }
  }

  void loadPopularMore() async {
    currentPagePopular.value++;
    url =
        'http://stagingauth.desidime.com/v4/home/discussed?per_page=10&page=${currentPagePopular.value}&fields=id.created_at.created_at_in_millis,image_medium,comments_count,store{name} ';
    if (hasPopularNextpage.value == true &&
        isPopularFirstLoadRunning.value == false &&
        isPopularLoadMoreRunning.value == false) {
      isPopularLoadMoreRunning.value = true;
      await GetData().getData(url).then((resp) {
        if (resp != {}) {
          Func().dPrint('--load more-- ${resp}');
          List<DealsModel>? list = (resp['deals'] as List<dynamic>)
              .map((e) => DealsModel.fromJson(e))
              .toList();
          if (list.isNotEmpty) {
            displayPopularData.addAll(list);
            hasPopularMoreData.value = true;
            hasPopularNextpage.value = true;
          } else {
            hasPopularMoreData.value = false;
            hasPopularNextpage.value = false;
          }
          isPopularLoadMoreRunning.value = false;
        } else {
          isPopularLoadMoreRunning.value = false;
          hasPopularMoreData.value = false;
          hasPopularNextpage.value = false;
        }
      });
    }
  }

  void loadFeaturedMore() async {
    currentPageFeatured.value++;
    url =
        'http://stagingauth.desidime.com/v4/home/discussed?per_page=10&page=${currentPageFeatured.value}&fields=id.created_at.created_at_in_millis,image_medium,comments_count,store{name} ';
    if (hasFeaturedNextpage.value == true &&
        isFeaturedFirstLoadRunning.value == false &&
        isFeaturedLoadMoreRunning.value == false) {
      isFeaturedLoadMoreRunning.value = true;
      await GetData().getData(url).then((resp) {
        if (resp != {}) {
          Func().dPrint('--load more-- ${resp}');
          List<DealsModel>? list = (resp['deals'] as List<dynamic>)
              .map((e) => DealsModel.fromJson(e))
              .toList();
          if (list.isNotEmpty) {
            displayFeaturedData.addAll(list);
            hasFeaturedMoreData.value = true;
            hasFeaturedNextpage.value = true;
          } else {
            hasFeaturedMoreData.value = false;
            hasFeaturedNextpage.value = false;
          }
          isFeaturedLoadMoreRunning.value = false;
        } else {
          isFeaturedLoadMoreRunning.value = false;
          hasFeaturedMoreData.value = false;
          hasFeaturedNextpage.value = false;
        }
      });
    } 
  }
}
