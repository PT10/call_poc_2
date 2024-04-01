import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:call_poc_2/pages/httpUtils.dart';
import 'package:call_poc_2/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'AgoraCall.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

final class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<SearchPage> {
  RxBool isDialing = false.obs;
  @override
  void dispose() {
    Get.deleteAll();
    super.dispose();
  }

  @override
  void initState() {
    if (loginType == 'pat') {
      Map<String, String> params = {};
      params["emergency_type"] = "1";
      params["accidental_type"] = "0";
      String url = baseUrl + "symptom_controller/list2";

      HttpUtils().post(url, params).then((value) {
        json.decode(value.body);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Agora Flutter QuickStart'),
        ),
        body: loginType == 'pat'
            ? _getPatientHomeScreen()
            : _getDoctorHomeScreen());
  }

  Widget _getPatientHomeScreen() {
    return Column(
      children: [],
    );
  }

  Widget _getDoctorHomeScreen() {
    return _getHomeWidget2();
  }

  Widget _getHomeWidget2() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 400,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Obx(() => isDialing.value
                      ? const Text("Dialing.. please wait")
                      : IconButton(
                          onPressed: () => onJoin(),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          icon: const Icon(Icons.call),
                        )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    isDialing.value = true;
    http.Response orderResp = await createOrder(specialisation);
    dynamic orderRespJson = json.decode(orderResp.body);
    String orderId = orderRespJson['data']['_id'];

    http.Response notiResp = await createNotification(orderId);
    dynamic notiRespJson = json.decode(notiResp.body);
    String channelName = notiRespJson['data']['channel_name'];

    pollForPickUpAction(orderId, channelName);
  }

  Future<http.Response> createOrder(String specialisation) async {
    Map<String, String> params1 = {};
    params1["patient_id"] = patientID;
    params1["recspecialisation_ideiver_id"] = specialisation;
    params1["latitude"] = "";
    params1["longitude"] = "";
    params1["doctor_id"] = docId;
    params1["isOtherEmergency"] = "0";
    String url = baseUrl + "order_controller/create";

    return HttpUtils().post(url, params1);
  }

  Future<http.Response> createNotification(String orderId) async {
    Map<String, String> params1 = {};
    params1["sender_id"] = patientID;
    params1["receiver_id"] = docId;
    params1["channel_name"] = Uuid().v4();
    params1["call_type"] = "0";
    params1["order_id"] = orderId;
    String url = baseUrl + "notification_controller/video_call";

    return HttpUtils().post(url, params1);
  }

  Future<void> pollForPickUpAction(String orderId, String channelName) async {
    Map<String, String> params1 = {};
    params1["order_id"] = orderId;
    String url = baseUrl + "order_controller/call_status_notify";

    HttpUtils().post(url, params1).then((value) async {
      dynamic resp = json.decode(value.body);

      if (resp['status'] == 1 && resp['data'] == 1) {
        // await for camera and mic permissions before pushing video page
        await _handleCameraAndMic(Permission.camera);
        await _handleCameraAndMic(Permission.microphone);
        // push video page with given channel name
        if (!mounted) {
          return;
        }

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgoraCall(
              channelName: channelName,
              role: ClientRole.Audience,
            ),
          ),
        );
      } else {
        Future.delayed(const Duration(milliseconds: 500),
            () => pollForPickUpAction(orderId, channelName));
      }
    });
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
