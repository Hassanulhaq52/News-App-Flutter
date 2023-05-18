
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_app/models/news_model.dart';

class ApiServices {
  Future<NewsModel?> getNewsData(String countryName) async {
    const String baseURL = 'https://newsapi.org/';
    const String apiKey = 'fb3dda4660964549935676992a2efb63';
    try {
      final String endPoint = 'v2/top-headlines?country=$countryName&apiKey=$apiKey';
      final dio = Dio();
      final response = await dio.get(baseURL + endPoint);
      debugPrint('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint('Response body: ${response.data}');
        NewsModel newsModel = NewsModel.fromJson(response.data);
        return newsModel;
      } else {
        debugPrint('ERROR: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
