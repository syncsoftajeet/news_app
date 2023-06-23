

import 'package:news_app/models/top_headline_response.dart';

import '../../../res/app_urls/app_url.dart';
import '../../network/network_api_services.dart';

class HomeRepsitory{

  final _apiService = NetworkApiServices();

  Future<TopHeadLineResponse> getTopHeadline() async{
    dynamic response = await _apiService.getApi(AppUrl.topHeadline);
    print(response);
    return TopHeadLineResponse.fromJson(response);
  }

  Future<TopHeadLineResponse> getBannerHeadline() async{
    dynamic response = await _apiService.getApi(AppUrl.topBannerHeadline);
        print(response);
    return TopHeadLineResponse.fromJson(response);
  }


  Future<TopHeadLineResponse> getHeadlineCategroy(String url) async{
    dynamic response = await _apiService.getApi(url);
    print(response);
    return TopHeadLineResponse.fromJson(response);
  }

}