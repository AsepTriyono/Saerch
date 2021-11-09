import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Model/search_model.dart';

class SearchApi{

  static List<String>  suges = [];



  static Future<List<NewDataSearch>> getSearchData({String? searchName}) async {


    List<NewDataSearch> items = [];
    try {
      var body = {
        "query": {
          "bool": {
            "must": [
              {
                "match": {
                  "name": searchName
                }
              }
            ],
            "filter": {
              "geo_distance": {
                "distance": "1000km",
                "pin.location": {
                  "lon": 105.2715969,
                  "lat": -6.3844006
                }
              }
            }
          }
        }
      };


      var response = await Dio().post(
          'http://api.lakukan.co.id/business-service/jasa/search', data:body);
      var jsonlist = response.data['hits']['hits'] as List;
      var item = jsonlist.map((e) => NewDataSearch.fromJson(e['_source']));

      if(item.isEmpty){
        return Future.error("Data tidak ada");
      }
      items.addAll(item);
      return items;
    } on DioError catch (e) {
      print(e.response);
      return items;
    }
  }
  static Future<List<NewDataSearch>> getDataUser({String? data}) async {
    List<NewDataSearch> items = [];
    try {
      var body = {
        "query": {
          "bool": {
            "must": [
              {
                "match": {
                  "_id": data
                }
              }
            ],
            "filter": {
              "geo_distance": {
                "distance": "1000km",
                "pin.location": {
                  "lon": 105.2715969,
                  "lat": -6.3844006
                }
              }
            }
          }
        }
      };

      log(body.toString());

      var response = await Dio().post(
          'http://api.lakukan.co.id/business-service/jasa/search', data:body);
      log(response.statusCode.toString());

      var jsonlist = response.data['hits']['hits'] as List;
      var item = jsonlist.map((e) => NewDataSearch.fromJson(e['_source']));
      items.addAll(item);
      // print(item.na);
      return items;
    } on DioError catch (e) {
      print(e.response);
      return items;
    }
  }

}