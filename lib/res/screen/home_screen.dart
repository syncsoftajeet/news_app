import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:news_app/models/top_headline_response.dart';
import 'package:news_app/res/colors/app_colors.dart';
import 'package:news_app/res/components/custom_app_bar.dart';
import 'package:news_app/res/components/custom_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../data/response/status.dart';
import '../../data/viewmodel/home_viewmodel.dart';
import '../components/news_items.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List categroyList = ["Entertainment","General","Health","Science","Sports","Technology","Business"];

  final homeController = Get.put(HomeViewModel());

  @override
  void initState() {
    super.initState();
    // homeController.getTopHeadline();
    homeController.getBannerHeadline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categroyList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: (){
                                Get.to(CategroyScreen(categroyList[index]));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                decoration: BoxDecoration(
                                    color: AppColors.blackColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "${categroyList[index]}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //Slider

                  Obx((){
                    switch(homeController.rxRequestStatus.value) {
                      case Status.LOADING:
                        print("---------loading-----------");
                        return Center(child: CircularProgressIndicator());

                      case Status.COMPLETE:
                        print("---------complete-----------");
                        List<Articles>? articallist = homeController.bannerHeadlinelist.value.articles;
                        return  CarouselSlider(
                    items: articallist?.map((item) {
                    return Builder(
                    builder: (BuildContext context) {
                    return _topHeadlineItems(item);
                    },
                    );
                    }).toList(),
                    options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                    ));

                      case Status.ERROR:
                        print("---------error-----------");
                        return Center(child: Text("error"));
                    }
                  }),



                    //Latest NewsList

                    SizedBox(
                      height: 21,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Latest News",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackColor,
                            fontSize: 21),
                      ),
                    ),

                  /*  Obx(() {
                      switch (homeController.rxRequestStatus.value) {
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());

                        case Status.COMPLETE:
                          return Container(
                            child: ListView.builder(
                                itemCount: homeController.topHeadlinelist.value.articles!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: _topHeadlineItems(homeController.topHeadlinelist.value.articles![index])),
                                        // child: NewsItems(homeController.topHeadlinelist.value.articles[index])),
                                  );
                                }),
                          );

                        case Status.ERROR:
                          return Center(child: Text("error"));
                      }
                    }),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _topHeadlineItems(Articles articles){
    String? url = articles.urlToImage;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
             url ?? 'https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=',
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
        ),
        Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [
                          Colors.black12.withOpacity(0),
                          Colors.black
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    )
                ),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      articles.title!,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "articles.description!",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )))
      ],
    );
  }

}
