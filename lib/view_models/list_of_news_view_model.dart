


import 'package:flutter/material.dart';
import 'package:mvvm_flutter_restapi_provider/models/news_model.dart';
import 'package:mvvm_flutter_restapi_provider/services/api_services.dart';

class NewsListViewModel extends ChangeNotifier {

  NewsModel _articlesList ;

  Future<void> fetchArticles() async {
    _articlesList = await API().fetchnews();
    notifyListeners();
  }
  NewsModel get articlesList => _articlesList;
}