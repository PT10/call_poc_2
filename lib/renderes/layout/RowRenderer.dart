import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/layout/rowLayout.dart';
import 'package:flutter/material.dart';

class RowRenderer extends ElementRenderer {
  const RowRenderer(super.type, super.elementModel,
      {super.initAction,
      super.onPollFinished,
      super.customDataModel,
      super.key});

  @override
  _RowRendererState createState() => _RowRendererState();
}

class _RowRendererState extends ElementRendererState<RowRenderer> {
  @override
  Widget getWidget() {
    RowLayout columnLayout = widget.elementModel as RowLayout;
    if (columnLayout.children == null) {
      return Container();
    }
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
        child: Row(
            children: columnLayout.children!.map((e) {
          Widget? w = RendererFactory.getWidget(e.subType, e,
              context: context,
              onAction: widget.onAction,
              onPollFinished: widget.onPollFinished);
          if (w == null) {
            return Container();
          }
          w = Column(children: [Expanded(child: w)]);
          if (e.giveEqualFlex ?? true) {
            return Expanded(flex: e.flex ?? 1, child: w);
          }
          return w;
        }).toList()));
  }
}
