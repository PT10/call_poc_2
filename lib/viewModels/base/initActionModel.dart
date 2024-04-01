import 'package:call_poc_2/pages/httpUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;

class InitActionModel {
  /*
    "initAction": {
        "api": "symptom_controller/list2",
        "params": {
          "emergency_type": "1",
          "accidental_type", "1"
        }
      }
  */

  final String api;
  final Map<String, dynamic> params;

  InitActionModel(this.api, this.params);

  factory InitActionModel.fromJson(Map<String, dynamic> json) {
    return InitActionModel(
        json["api"], Map<String, dynamic>.from(json["params"] ?? []));
  }

  Future<http.Response> perform(
      BuildContext context, Map<String, dynamic>? data) async {
    if (data != null) {
      params.keys.forEach((key) {
        if (data.containsKey(key)) {
          params[key] = data[key];
        }
      });
    }
    return HttpUtils().post(api, params);
  }
}
