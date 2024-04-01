import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ElementRenderer extends StatefulWidget {
  // final Widget myCmp;
  final InitActionModel? initAction;
  final Function(Response?) getCmp;
  final Map<String, dynamic>? data;
  const ElementRenderer(
      {required this.getCmp, this.initAction, this.data, super.key});

  @override
  State<ElementRenderer> createState() => _ElementRendererState();
}

class _ElementRendererState extends State<ElementRenderer> {
  @override
  Widget build(BuildContext context) {
    if (widget.initAction != null) {
      return FutureBuilder(
        future: widget.initAction!.perform(context, widget.data),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return widget.getCmp(snapshot.data);
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("error"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
    return widget.getCmp(null);
  }
}
