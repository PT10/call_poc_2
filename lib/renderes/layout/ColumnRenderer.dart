import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/layout/columnLayout.dart';
import 'package:flutter/material.dart';

class ColumnRenderer extends ElementRenderer {
  const ColumnRenderer(super.type, super.elementModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _ColumnRendererState createState() => _ColumnRendererState();
}

class _ColumnRendererState extends ElementRendererState<ColumnRenderer> {
  @override
  Widget getWidget() {
    return Column(
        children: (widget.elementModel as ColumnLayout).children!.map((e) {
      return Expanded(
          child: Card(
              child: Row(children: [
        Expanded(
            child: RendererFactory.getWidget(e.subType, e, context: context,
                onAction: (type) {
          if (type == "refresh") {
            setState(() {});
          }

          if (widget.onAction != null) {
            widget.onAction!(type);
          }
        }, onPollFinished: widget.onPollFinished))
      ])));
    }).toList());
  }
}
