import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/layout/columnLayout.dart';
import 'package:flutter/material.dart';

class ColumnRenderer extends ElementRenderer {
  const ColumnRenderer(super.type, super.elementModel,
      {super.initAction,
      super.onPollFinished,
      super.customDataModel,
      super.key});

  @override
  _ColumnRendererState createState() => _ColumnRendererState();
}

class _ColumnRendererState extends ElementRendererState<ColumnRenderer> {
  @override
  Widget getWidget() {
    List<Widget> children = [];
    (widget.elementModel as ColumnLayout).children!.forEach((e) {
      Widget? w = RendererFactory.getWidget(e.subType, e, context: context,
          onAction: (type) {
        if (type == "refresh") {
          setState(() {});
        }

        if (widget.onAction != null) {
          widget.onAction!(type);
        }
      }, onPollFinished: widget.onPollFinished);
      if (w == null || w is Container) {
        return;
      }
      w = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: w)]);
      if (e.giveEqualFlex ?? true) {
        return children.add(Expanded(flex: e.flex ?? 1, child: w));
      }
      return children.add(w);
    });
    return Card(child: Column(children: children));
  }
}
