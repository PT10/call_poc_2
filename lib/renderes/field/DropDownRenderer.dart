import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/field/dropDownField.dart';
import 'package:flutter/material.dart';

class DropDownRenderer extends ElementRenderer {
  const DropDownRenderer(super.type, super.elementModel,
      {required super.getCmp,
      super.initAction,
      super.onPollFinished,
      super.onAction,
      super.key});

  @override
  _DropDownRendererState createState() => _DropDownRendererState();
}

class _DropDownRendererState extends ElementRendererState<DropDownRenderer> {
  String? selectedVal;
  late DropDownField fieldModel;

  @override
  void initState() {
    super.initState();
    fieldModel = widget.elementModel as DropDownField;
    selectedVal = fieldModel.value;
  }

  @override
  Widget getWidget(CustomDataModel? customModel) {
    //DataModel model = Provider.of<DataModel>(context, listen: false);

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          label: Text(fieldModel.buttonText ?? ''),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ))),
      value: selectedVal,
      onChanged: (val) {
        setState(() {
          selectedVal = val;
        });

        /* if (widget.onAction != null) {
          widget
              .onAction!(); // Action performed on the parent component.. e.g. close popup window
        } */
        if (fieldModel.action != null) {
          fieldModel.action!.forEach(
              (element) => element.setData({fieldModel.id: val}, context));
          fieldModel.action!.forEach((element) =>
              element.perform(context, actionCallBack: widget.onAction));
        }
      },
      items: fieldModel.values
          .map((e) => DropdownMenuItem<String>(
                value: e["id"],
                child: Text(e["name"]),
              ))
          .toList(),
    );
  }
}
