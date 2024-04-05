import 'dart:convert';

import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ElementRenderer extends StatefulWidget {
  // final Widget myCmp;
  final InitActionModel? initAction;
  final Function(Map<String, dynamic>?) getCmp;
  final Map<String, dynamic> data;
  final Function? onPollFinished;
  const ElementRenderer(
      {required this.getCmp,
      this.initAction,
      required this.data,
      this.onPollFinished,
      super.key});

  @override
  State<ElementRenderer> createState() => _ElementRendererState();
}

class _ElementRendererState extends State<ElementRenderer> {
  bool loadingCompleted = false;
  //Map<String, dynamic> data = {};
  String? errorMsg;
  @override
  void initState() {
    if (widget.initAction != null) {
      _performInitAction();
    } else {
      loadingCompleted = true;
    }
    super.initState();
  }

  _performInitAction({bool pollModel = false}) {
    // Init action can also update the widget.data
    widget.initAction!
        .perform(context, widget.data, pollMode: pollModel)
        .then((value) {
      setState(() {
        loadingCompleted = true;
        widget.data.addAll(json.decode(value.body));
      });

      InitAction lastAction = widget.initAction!.initActions.last;
      if (lastAction.mode == "poll" && lastAction.breakCondition != null) {
        var resp = json.decode(value.body);
        if (resp[lastAction.breakCondition!["field"]] !=
            lastAction.breakCondition!["value"]) {
          return Future.delayed(Duration(microseconds: 500),
              () => _performInitAction(pollModel: true));
        }

        if (widget.onPollFinished != null) {
          widget.onPollFinished!(lastAction.action);
        }
      }
      // setState(() {
      //   loadingCompleted = true;
      //   data.addAll(json.decode(value.body));
      // });
    }).onError((error, stackTrace) {
      errorMsg = "Error";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loadingCompleted) {
      return widget.getCmp(widget.data);
    } else if (errorMsg != null) {
      return const Center(
        child: Text("error"),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
