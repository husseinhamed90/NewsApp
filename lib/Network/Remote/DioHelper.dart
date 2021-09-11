import 'package:dio/dio.dart';
import 'package:loginpagechallenge/Models/NewsAPI.dart';
import 'package:loginpagechallenge/Network/Remote/EndPoints.dart';

class DioHelper{
  static late Dio dio ;
  static String apiKey="25bf51ed51cb457a894f72f5aa390ac3";
  static String baseUrl ="https://newsapi.org/v2/";

  static init(){
     dio = Dio();
  }

  static Future<NewsApi> getNews(int numberOfPage,String category) async {

    NewsApi newsApi=new NewsApi();

    await dio.get('$baseUrl$topHeadlines',queryParameters: {"country":"eg","category":"$category","apiKey":"$apiKey","page":numberOfPage}).then((response) {
      newsApi=NewsApi.fromJson(response.data);
    }).onError((error, stackTrace) {
      print("error");
    });
    removeSpeceificSourceNews(newsApi);
    return newsApi;
  }


  static Future<NewsApi> getNewsWithSearchedText(int numberOfPage,String searchString) async {
    NewsApi newsApi=new NewsApi();
    await dio.get('$baseUrl$topHeadlines',queryParameters: {"q":"$searchString","apiKey":"$apiKey","page":numberOfPage}).then((response) {
      newsApi=NewsApi.fromJson(response.data);
    }).onError((error, stackTrace) {
      print("error");
    });
    removeSpeceificSourceNews(newsApi);
    return newsApi;
  }


  static void removeSpeceificSourceNews(NewsApi newsApi) {
     for(int i=0;i<newsApi.articles!.length;i++){
      if(newsApi.articles![i].source!.name=="Aljazeera.net"){
        newsApi.articles!.removeAt(i);
      }
    }
  }
}




