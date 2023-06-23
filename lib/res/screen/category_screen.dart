import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/response/status.dart';
import '../../data/viewmodel/home_viewmodel.dart';
import '../../models/top_headline_response.dart';
import '../components/custom_app_bar.dart';

class CategroyScreen extends StatefulWidget {
   CategroyScreen(this.catName, {Key? key}) : super(key: key);


   String catName;

  @override
  State<CategroyScreen> createState() => _CategroyScreenState();
}

class _CategroyScreenState extends State<CategroyScreen> {




  final homeController = Get.put(HomeViewModel());



  @override
  void initState() {
    super.initState();
    homeController.getHeadlineCategroy('https://newsapi.org/v2/top-headlines?country=in&category=${widget.catName}&apiKey=cf27c8e245f946aebd42ac4276840f4d');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: CustomAppBar(),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Text(widget.catName,style: TextStyle(
                fontSize: 21,color: Colors.black,fontWeight: FontWeight.w700
              ),),
            ),
            Obx(() {
              switch (homeController.rxRequestStatus.value) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());

                case Status.COMPLETE:
                  try{
                  return Expanded(
                    child: ListView.builder(
                        itemCount: homeController.topHeadlinelist.value.articles!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
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
                  }catch(e){
                    print(e);
                    return Container();
                  }

                case Status.ERROR:
                  return Center(child: Text("error"));
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _topHeadlineItems(Articles articles){

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: articles.urlToImage!=null ? Image.network(
            articles.urlToImage!,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ): Image.network("https://t4.ftcdn.net/jpg/01/67/74/79/360_F_167747932_NE1da5cf9FM30QExtlFjbmk9ypItoJl2.jpg"),
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
                      articles.description!,
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

