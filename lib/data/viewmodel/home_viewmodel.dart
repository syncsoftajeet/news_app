
import 'package:get/get.dart';
import 'package:news_app/data/repository/home_repository/home_repository.dart';
import 'package:news_app/models/top_headline_response.dart';

import '../response/status.dart';

class HomeViewModel extends GetxController{

  final _repository = HomeRepsitory();
  final rxRequestStatus = Status.LOADING.obs;
  final rxBannerRequestStatus = Status.LOADING.obs;

  final RxBool loading = false.obs;
  final RxBool bannerloading = false.obs;
  final topHeadlinelist = TopHeadLineResponse().obs;
  final bannerHeadlinelist = TopHeadLineResponse().obs;

  void setRxStatus(Status _value) => rxRequestStatus.value = _value;
  void setTopHeadline(TopHeadLineResponse _value) => topHeadlinelist.value = _value;

  void getTopHeadline(){
    loading.value = true;
        _repository.getTopHeadline().then((value){
          setRxStatus(Status.COMPLETE);
          setTopHeadline(value);
        }).onError((error, stackTrace){
          setRxStatus(Status.ERROR);
        });
    loading.value = false;
  }


  void getHeadlineCategroy(String url){
    loading.value = true;
    _repository.getHeadlineCategroy(url).then((value){
      setRxStatus(Status.COMPLETE);
      setTopHeadline(value);
    }).onError((error, stackTrace){
      setRxStatus(Status.ERROR);
    });
    loading.value = false;
  }


  void getBannerHeadline(){
    bannerloading.value = true;
    _repository.getBannerHeadline().then((value){
      rxBannerRequestStatus.value = Status.COMPLETE;
      bannerHeadlinelist.value = value;
    }).onError((error, stackTrace){
      rxBannerRequestStatus.value = Status.ERROR;
    });
    bannerloading.value = false;
  }

}