import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/layout/columnLayout.dart';
import 'package:flutter/material.dart';

class ColumnRenderer extends ElementRenderer {
  const ColumnRenderer(super.type, super.layoutModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _ColumnRendererState createState() => _ColumnRendererState();
}

class _ColumnRendererState extends ElementRendererState<ColumnRenderer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget getWidget() {
    return Column(
        children: (widget.layoutModel as ColumnLayout).children!.map((e) {
      return Expanded(
          child: Card(
              child: Row(children: [
        Expanded(
            child: RendererFactory.getWidget(e.subType, e,
                context: context,
                onAction: widget.onAction,
                onPollFinished: widget.onPollFinished))
      ])));
    }).toList());
  }
}
