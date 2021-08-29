import 'dart:convert';

import 'package:mvvm_flutter_restapi_provider/models/news_model.dart';
import 'package:http/http.dart' as http;
class API{


  final String apiKey = '36479e94e45240c4b564463b32061aff';

  Future<NewsModel> fetchnews() async {
    print("helllllllllllllllllo");
    try {
      http.Response response = await http.get(
          'https://newsapi.org/v2/top-headlines?country=eg&apiKey=$apiKey');
      if (response.statusCode == 200) {
        String res = response.body;
        var data = NewsModel.fromJson(jsonDecode(res));
        print("jdsfklsdjkf ${data.articles[0].title}");
        return data;
      } else {
        print('status code = ${response.statusCode}');
      }
    } catch (ex) {
      print(ex);
    }
  }


}