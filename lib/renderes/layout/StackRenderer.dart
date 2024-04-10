import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/layout/stackLayout.dart';
import 'package:flutter/material.dart';

class StackRenderer extends ElementRenderer {
  const StackRenderer(super.type, super.layoutModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _StackRendererState createState() => _StackRendererState();
}

class _StackRendererState extends ElementRendererState<StackRenderer> {
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
    StackLayout stackLayout = widget.layoutModel as StackLayout;
    if (stackLayout.children == null) {
      return Container();
    }
    return Stack(
        children: stackLayout.children!.map((e) {
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
