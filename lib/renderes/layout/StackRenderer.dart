import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/layout/stackLayout.dart';
import 'package:flutter/material.dart';

class StackRenderer extends ElementRenderer {
  const StackRenderer(super.type, super.elementModel,
      {super.initAction,
      super.onPollFinished,
      super.customDataModel,
      super.key});

  @override
  _StackRendererState createState() => _StackRendererState();
}

class _StackRendererState extends ElementRendererState<StackRenderer> {
  @override
  Widget getWidget() {
    StackLayout stackLayout = widget.elementModel as StackLayout;
    if (stackLayout.children == null) {
      return Container();
    }
    return Stack(
        children: stackLayout.children!.map((e) {
      Widget? w = RendererFactory.getWidget(e.subType, e,
          context: context,
          onAction: widget.onAction,
          onPollFinished: widget.onPollFinished);
      if (w == null) {
        return Container();
      }
      return Expanded(child: Card(child: Row(children: [Expanded(child: w)])));
    }).toList());
  }
}
