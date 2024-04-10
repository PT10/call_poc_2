import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:call_poc_2/pages/AgoraCall.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class AgoraCallPage extends FieldBase {
  AgoraCallPage(super.type, super.subType);

  @override
  factory AgoraCallPage.fromJson(Map<String, dynamic> json) {
    return AgoraCallPage(json["type"], json["subType"]);
  }
}
