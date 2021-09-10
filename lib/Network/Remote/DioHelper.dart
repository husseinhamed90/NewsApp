import 'package:dio/dio.dart';
import 'package:loginpagechallenge/Models/NewsAPI.dart';
import 'package:loginpagechallenge/Network/Remote/EndPoints.dart';


/// More examples see https://github.com/flutterchina/dio/tree/master/example

class DioHelper{
  static late Dio dio ;
  static String apiKey="25bf51ed51cb457a894f72f5aa390ac3";
  static String baseUrl ="https://newsapi.org/v2/";




  static init(){
     dio = Dio();
  }
  // static Future<NewsApi> getArticles() async {
  //
  //   NewsApi newsApi=new NewsApi();
  //   Response response = await dio.get('$baseUrl$everything?q=bitcoin&from=2021-07-31&sortBy=publishedAt&apiKey=$apiKey');
  //   newsApi=NewsApi.fromJson(response.data);
  //   return newsApi;
  // }


  static Future<NewsApi> getNewsSources(int numberOfPage,String category) async {

    NewsApi newsApi=new NewsApi();

    // await dio.get("https://newsapi.org/v2/top-headlines?apiKey=25bf51ed51cb457a894f72f5aa390ac3&country=eg&category=$category&page=$numberOfPage").then((response) {
    //   newsApi=NewsApi.fromJson(response.data);
    // }).onError((error, stackTrace) {
    //   print("error");
    // });
    await dio.get('$baseUrl$topHeadlines',queryParameters: {"country":"eg","category":"$category","apiKey":"$apiKey","page":numberOfPage}).then((response) {
      newsApi=NewsApi.fromJson(response.data);
      for(int i=0;i<newsApi.articles!.length;i++){
        if(newsApi.articles![i].source!.name=="Aljazeera.net"){
          newsApi.articles!.removeAt(i);
        }
      }
    }).onError((error, stackTrace) {
      print("error");
    });
    return newsApi;
  }
}




