import 'dart:io';

import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/pages/httpUtils.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/views/conciergeFlow.dart';
import 'package:call_poc_2/views/homeScreen.dart';
import 'package:call_poc_2/views/loginFlow.dart';
import 'package:call_poc_2/views/patientFlow.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../settings.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<String?>? fcmFuture;
  Future<BaseDeviceInfo>? deviceFuture;

  @override
  void initState() {
    fcmFuture = FirebaseMessaging.instance.getToken();
    fcmFuture?.then((value) => fcmId = value);
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (!kIsWeb) {
      deviceFuture = Platform.isIOS
          ? deviceInfo.iosInfo
          : Platform.isAndroid
              ? deviceInfo.androidInfo
              : null;
    }
    deviceFuture?.then((value) {
      if (Platform.isAndroid) {
        deviceId = (value as AndroidDeviceInfo).id;
      } else if (Platform.isIOS) {
        deviceId = (value as IosDeviceInfo).identifierForVendor;
      }
    });
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      fcmId = fcmToken;
      //updateTokenDeviceLogin();
    }).onError((err) {});
    updateTokenDeviceLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BaseModel model = BaseModel.fromJson(conciergeScaffold);
    DataModel d = DataModel({
      //"patient_id": "65c9f89d031272e866295a9a",
      //"latitude": "18.577954759165255",
      //"longitude": "73.76560389261459"
    });

    return MultiProvider(
        providers: [ChangeNotifierProvider<DataModel>.value(value: d)],
        builder: (context, child) =>
            RendererFactory.getWidget(model.subType, model,
                context: context, onAction: (_) {}) ??
            Container() //ElementRenderer(model.subType, model, getCmp: (_) {}),
        );

    // return ChangeNotifierProvider<DataModel>(
    //     create: (context) => DataModel(model.data),
    //     child: Scaffold(
    //         appBar: AppBar(
    //           title: const Text("Login"),
    //         ),
    //         body: model.render(context))
    /* Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(children: [
                  DropdownButton(
                      value: loginType,
                      items: const <DropdownMenuItem>[
                        DropdownMenuItem(
                          value: 'doc',
                          child: Text("Doctor"),
                        ),
                        DropdownMenuItem(
                          value: 'pat',
                          child: Text("Patient"),
                        )
                      ],
                      onChanged: (val) {
                        setState(() {
                          loginType = val;
                          updateTokenDeviceLogin();
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: fcmFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        fcmId = snapshot.data;
                        return FutureBuilder(
                          future: deviceFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (Platform.isIOS) {
                                deviceId = (snapshot.data as IosDeviceInfo)
                                    .identifierForVendor;
                              } else {
                                deviceId =
                                    (snapshot.data as AndroidDeviceInfo).id;
                              }
                              return ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchPage()));
                                  },
                                  child: const Text("Login"));
                            } else {
                              return showProgressCircle();
                            }
                          },
                        );
                      } else {
                        return showProgressCircle();
                      }
                    },
                  )
                ])
              ])
            ])*/
    //);
  }

  updateTokenDeviceLogin() {
    /*  Map<String, String> params = {};
    params["token"] = fcmId ?? '';
    params["user_id"] = loginType == 'pat' ? patientID : docId;
    params["type"] = loginType == 'pat' ? "0" : "1";
    params["device_type"] = Platform.isAndroid ? "0" : "1";
    params["mobile_device_id"] = deviceId ?? '';
    params["latitude"] = "18.577905476265904";
    params["longtude"] = "73.76547982075654";
    String url = baseUrl + "notification_controller/subscribe";
    HttpUtils().post(url, params); */
  }

  showProgressCircle() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
