import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/layout/rowLayout.dart';
import 'package:flutter/material.dart';

class RowRenderer extends ElementRenderer {
  const RowRenderer(super.type, super.layoutModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _RowRendererState createState() => _RowRendererState();
}

class _RowRendererState extends ElementRendererState<RowRenderer> {
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
    RowLayout columnLayout = widget.layoutModel as RowLayout;
    if (columnLayout.children == null) {
      return Container();
    }
    return Card(
        child: Row(
            children: columnLayout.children!.map((e) {
      return Expanded(
          child: Column(children: [
        Expanded(
            child: RendererFactory.getWidget(e.subType, e,
                context: context,
                onAction: widget.onAction,
                onPollFinished: widget.onPollFinished))
      ]));
    }).toList()));
  }
}
