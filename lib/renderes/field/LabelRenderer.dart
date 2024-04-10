import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/field/labelField.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabelRenderer extends ElementRenderer {
  const LabelRenderer(super.type, super.layoutModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.key});

  @override
  _LabelRendererState createState() => _LabelRendererState();
}

class _LabelRendererState extends ElementRendererState<LabelRenderer> {
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
    DataModel model = Provider.of<DataModel>(context, listen: false);
    LabelField fieldModel = widget.layoutModel as LabelField;
    return Wrap(
      children: skipNulls([
        fieldModel.label != null ? Text(fieldModel.label!) : null,
        fieldModel.valueField != null
            ? Text(model.data[fieldModel.valueField]?.toString() ?? '')
            : null
      ]),
    );
  }
}
