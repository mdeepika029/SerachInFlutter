import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:money_tap_app/data/LoggingInterceptor.dart';
import 'package:money_tap_app/screens/models/HomeSectionModel.dart';


class MoneyTapAPiProvider {
  static const String URL_API_PROD = 'https://en.wikipedia.org/';
  static const String url = 'https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=';

  Dio dio = new Dio();

  /*MoneyTapAPiProvider() {
    print("###into APIMAP provider");
    dio.BaseOptions options =
    dio.BaseOptions(receiveTimeout: 15000, connectTimeout: 15000,baseUrl:URL_API_PROD );

    _dio = dio.Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (Options option) async{}
    ));
    _dio.interceptors.add(LoggingInterceptor());
  }*/


  Future<HomeSectionModel> getHomeSectionData(String searchtext) async {
    try {
      String reqUrl = url + searchtext + '+T&gpslimit=15' ;
      Response response = await dio.get(reqUrl);
      print('### response ### ${response.data}');
      return HomeSectionModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }


}
