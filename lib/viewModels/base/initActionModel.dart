import 'dart:convert';

import 'package:call_poc_2/pages/httpUtils.dart';
import 'package:call_poc_2/settings.dart';
import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class InitActionModel {
  /*
    "initAction": [{
        "api": "symptom_controller/list2",
        "params": {
          "emergency_type": "1",
          "accidental_type", "1"
        }
      }]
  */

  List<InitAction> initActions;

  InitActionModel(this.initActions);

  factory InitActionModel.fromJson(List<Map<String, dynamic>> json) {
    List<InitAction> tempActions = [];

    json.forEach(
      (element) {
        tempActions.add(InitAction(replaceVariables(element["api"])!,
            Map<String, dynamic>.from(element["params"] ?? {}),
            mode: element["mode"],
            breakCondition: element["breakCondition"],
            action: element.containsKey("action")
                ? ActionBase.fromJson(element["action"])
                : null));
      },
    );

    return InitActionModel(tempActions);
  }

  Future<http.Response> perform(BuildContext context,
      {bool pollMode = false}) async {
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    if (initActions.length == 1) {
      if (componentData != null) {
        _updateActionParams(0, componentData.data);
      }
      return HttpUtils().post(initActions[0].api, initActions[0].params);
    }

    //data ??= {};

    int i = initActions.length - 1;
    if (!pollMode) {
      for (i = 0; i < initActions.length - 1; i++) {
        initActions[i].params.keys.forEach((key) {
          //if (data != null) {
          _updateActionParams(i, componentData.data);
          //}
        });

        http.Response resp =
            await HttpUtils().post(initActions[i].api, initActions[i].params);
        var respObj = json.decode(resp.body);
        componentData.setData(respObj["data"]);
      }
    }

    initActions[i].params.keys.forEach((key) {
      // if (data != null) {
      _updateActionParams(i, componentData.data);
      //}
      // if (data!.containsKey(key)) {
      //   initActions[i].params[key] = data[key];
      // }
    });

    return HttpUtils().post(initActions[i].api, initActions[i].params);
  }

  _updateActionParams(int i, Map<String, dynamic> data) {
    initActions[i].params.keys.forEach((key) {
      if (initActions[i].params[key] == "__randStr__") {
        initActions[i].params[key] = Uuid().v4().toString();
        return;
      }
      if (initActions[i].params[key] == "__FCM_TOKEN__") {
        initActions[i].params[key] = fcmId;
        return;
      }
      if (initActions[i].params[key] == "__DEVICE_ID__") {
        initActions[i].params[key] = deviceId;
        return;
      }
      if (initActions[i].params[key] is Map<String, dynamic>) {
        if (data!.containsKey(initActions[i].params[key]["oldKey"])) {
          initActions[i].params[key] =
              data[initActions[i].params[key]["oldKey"]];
        } else if (globalVariables
            .containsKey(initActions[i].params[key]["oldKey"])) {
          initActions[i].params[key] =
              globalVariables[initActions[i].params[key]["oldKey"]];
        }
      } else {
        if (data!.containsKey(key)) {
          if (initActions[i].params[key] is String) {
            initActions[i].params[key] = data[key].toString();
          } else {
            initActions[i].params[key] = data[key];
          }
        }
      }
    });
  }

  // Future<http.Response> performImpl(
  //     BuildContext context, Map<String, dynamic>? data) async {
  //   if (data != null) {
  //     action.params.keys.forEach((key) {
  //       if (data.containsKey(key)) {
  //         action.params[key] = data[key];
  //       }
  //     });
  //   }
  //   return HttpUtils().post(action.api, action.params);
  // }
}

class InitAction {
  final String api;
  final Map<String, dynamic> params;
  final String? mode;
  final Map<String, dynamic>? breakCondition;
  final ActionBase? action;

  InitAction(this.api, this.params,
      {this.mode, this.action, this.breakCondition});
}
