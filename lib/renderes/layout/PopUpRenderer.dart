import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/layout/popupLayout.dart';
import 'package:flutter/material.dart';

class PopUpRenderer extends ElementRenderer {
  const PopUpRenderer(super.type, super.layoutModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.onAction,
      super.key});

  @override
  _PopUpRendererState createState() => _PopUpRendererState();
}

class _PopUpRendererState extends ElementRendererState<PopUpRenderer> {
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
    PopupLayout popupModel = widget.layoutModel as PopupLayout;
    if (popupModel.children == null) {
      return Container();
    }
    return AlertDialog(
      content: Column(
          children: popupModel.children!.map((e) {
        return Expanded(
            child: Card(
                child: Row(children: [
          Expanded(
              child: RendererFactory.getWidget(e.subType, e,
                  context: context,
                  onAction: widget.onAction,
                  onPollFinished: widget.onPollFinished))
        ])));
      }).toList()),
      actions: popupModel.actions?.map<Widget>((e) {
        return RendererFactory.getWidget(e.subType, e,
            context: context,
            onAction: widget.onAction,
            onPollFinished: widget.onPollFinished);
      }).toList(),
    );
  }
}
